output "ip-address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.network_data[0].ip_address, i.ports[0].external])]
  description = "The IP address and external port of the container 1"
}


output "container-name" {
  value       = [for i in docker_container.nodered_container[*] : i.name]
  description = "The name of the container"
}