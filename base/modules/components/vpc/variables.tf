# Variables for the VPC

# Set the environment
variable "env" {
  type        = string
  description = "Environment to deploy to"
}

variable "aws_region" {
  description = "AWS Region"
}
variable "vpc_cidr" {
  description = "CIDR block"
}

variable "public_subnets_cidr" {
  description = "CIDR for public subnet"
  type        = list(any)
}

variable "private_subnets_cidr" {
  description = "CIDR for the private subnet"
  type        = list(any)
}

variable "availability_zones" {
  description = "AZ count"
  type        = list(any)
}

# Bastion stuff
# Whitelist Service: required by bastion module
variable "cidr_blocks_whitelist_service" {
  description = "range(s) of incoming IP addresses to whitelist"
  type        = list(string)
  default     = []
}

variable "everyone_cidr" {
  default     = "0.0.0.0/0"
  description = "Everyone"
}

variable "public_ip" {
  default     = false
  description = "Associate a public IP with the host instance during launch"
}

variable "bastion_instance_types" {
  description = "List of ec2 types for the bastion host"
  default     = ["t3.small", "t3.medium", "t3.large", ]
}