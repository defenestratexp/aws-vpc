# NAT

resource "aws_nat_gateway" "n9n_nat_gw" {
  allocation_id = aws_eip.n9n_nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.n9n_ig]
  tags = {
    Name        = "${var.env}-nat"
    Environment = "${var.env}"
  }
}