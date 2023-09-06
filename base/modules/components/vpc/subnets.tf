# Define subnets for the VPC

# Public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.n9n_vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.env}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment = "${var.env}"
    Filter      = "public_subnet"
  }
}

# Private subnets
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.n9n_vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.env}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment = "${var.env}"
    Filter      = "private_subnet"
  }
}
