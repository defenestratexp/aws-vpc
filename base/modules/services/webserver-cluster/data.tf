# Data sources for the cluster

# This example uses the AWS default VPC
# To call it, define a source here
# If an app uses a different VPC name it here
data "aws_vpc" "default" {
  default = true
}

# This source contains the subnets for the VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
