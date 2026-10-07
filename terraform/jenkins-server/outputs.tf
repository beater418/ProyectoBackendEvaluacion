output "server_ip" {
  description = "IP publica del servidor"
  value       = digitalocean_droplet.backend.ipv4_address
}

output "ssh_command" {
  description = "Comando SSH"
  value       = "ssh root@${digitalocean_droplet.backend.ipv4_address}"
}

output "backend_url" {
  description = "URL publica del backend"
  value       = "http://${digitalocean_droplet.backend.ipv4_address}:3000"
}