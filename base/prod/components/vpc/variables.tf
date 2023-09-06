variable "region" {
  description = "AWS region for the resources"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "The environment for the resources"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  # type        = list(any)
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "CIDR for the public subnet"
  type        = list(any)
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  description = "CIDR for the private subnet"
  type        = list(any)
  default     = ["10.0.10.0/24"]
}

locals {
  prod_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}