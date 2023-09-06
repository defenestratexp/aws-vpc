# Default security groups for the VPC
resource "aws_security_group" "default" {
  name        = "${var.env}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.n9n_vpc.id
  depends_on  = [aws_vpc.n9n_vpc]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name        = "${var.env}-default-sg"
    Environment = "${var.env}"
  }
}