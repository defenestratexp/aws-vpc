# Create a VPC
resource "aws_vpc" "n9n_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.env}-vpc"
    Environment = "${var.env}"
  }
}