variable "env" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "dev_group_min" {
  description = "Minimum number of hosts"
  type        = number
  default     = 1
}

variable "dev_group_max" {
  description = "Maximum number of hosts"
  type        = number
  default     = 1
}

variable "image_id" {
  description = "AMI to use on target hosts"
  type        = string
  default     = "ami-0638741e0c9aabde6"
}

variable "liferay_instance_type" {
  description = "Size of the hosts"
  default     = ["t3.large", "t3.xlarge"]
}

variable "server_port" {
  description = "Port Liferay listens on"
  type        = number
  default     = 80
}