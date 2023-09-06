# Variables related to a webserver cluster
variable "server_port" {
  type        = number
  description = "Port the webserver listens on"
  default     = "80"
}