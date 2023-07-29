terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

variable "ext_port" {
    type = number
    default = 1880
    
    validation {
        condition = var.ext_port <= 65535 && var.ext_port > 0
        error_message = "The external port must be in the valid port range 0 - 65535"
    }
}

variable "int_port" {
    type = number
    default = 1880
    
    validation {
        condition = var.int_port == 1880
        error_message = "The internal port must be 1880."
    }
}

variable "container_count" {
    type = number
    default = 1
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
}

output "ip-address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.network_data[0].ip_address, i.ports[0].external])]
  description = "The IP address and external port of the container 1"
}


output "container-name" {
  value       = [for i in docker_container.nodered_container[*] : i.name]
  description = "The name of the container"
}