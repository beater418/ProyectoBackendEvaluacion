variable "region" {
  description = "Region de DigitalOcean"
  type        = string
  default     = "nyc3"
}

variable "droplet_size" {
  description = "Tamano del servidor"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ssh_public_key_path" {
  description = "Ruta de la llave publica SSH"
  type        = string
}