terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "null_resource" "dockervol" {
    provisioner "local-exec" {
        command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/" 
    }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  count = 1
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id

  ports {
    internal = var.int_port
    external = var.ext_port
  }
  
  volumes {
      container_path = "/data"
      host_path = "/home/ubuntu/environment/terraform-docker/noderedvol"
  }
}

