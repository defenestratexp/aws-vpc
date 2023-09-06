# Set the required version of terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

# Instruct terraform to use AWS
provider "aws" {
  region = "us-east-1"
}