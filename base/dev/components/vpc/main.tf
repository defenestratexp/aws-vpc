# Dev VPC
module "vpc" {
  source               = "../../../modules/components/vpc"
  env                  = var.env
  availability_zones   = local.dev_availability_zones
  vpc_cidr             = var.vpc_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  aws_region           = var.region
}