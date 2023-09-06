# An Elastic IP for NAT
resource "aws_eip" "n9n_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.n9n_ig]
}