# Create a bastion host in the VPC
module "ssh-bastion-service" {
  source                        = "github.com/joshuamkite/terraform-aws-ssh-bastion-service"
  aws_region                    = var.aws_region
  environment_name              = var.env
  vpc                           = aws_vpc.n9n_vpc.id
  subnets_asg                   = flatten([aws_subnet.private_subnet.*.id])
  subnets_lb                    = flatten([aws_subnet.private_subnet.*.id])
  cidr_blocks_whitelist_service = [var.everyone_cidr]
  public_ip                     = true
  bastion_instance_types        = ["t3.micro"]
}