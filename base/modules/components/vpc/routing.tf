# Route table definitions

# Public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.n9n_vpc.id

  tags = {
    Name        = "${var.env}-public-route-table"
    Environment = "${var.env}"
  }
}

# Private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.n9n_vpc.id

  tags = {
    Name        = "${var.env}-private-route-table"
    Environment = "${var.env}"
  }
}

# Route definitions
# Connect the public route to the public table and internet gateway
# Internet Gateway is defined in gateway.tf
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.n9n_ig.id
}

# Connect the private route to the private table and NAT gateway
# NAT gateway is defined in nat.tf
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.n9n_nat_gw.id
}

# Route Table associations
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}