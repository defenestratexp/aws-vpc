# Internet Gateway (IGW) for the VPC
resource "aws_internet_gateway" "n9n_ig" {
  vpc_id = aws_vpc.n9n_vpc.id

  tags = {
    Name        = "${var.env}-igw"
    Environment = "${var.env}"
  }
}