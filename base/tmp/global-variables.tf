# Global variables/defaults

variable "default_region" {
  type        = string
  description = "The region the infra lives in"
  default     = "us-east-1"
}

variable "instance_size" {
  type        = string
  description = "EC2 instance size"
  default     = "t2.small"
}

# For test web server
variable "n9n_web_1_port" {
  type        = number
  description = "Sample server listen port"
  default     = 8080
}
