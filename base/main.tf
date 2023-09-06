provider "aws" {
  region = var.region
}

module "dev_vpc_init" {
  source = "./dev/components/vpc"
}

module "stage_vpc_init" {
  source = "./stage/components/vpc"
}

module "prod_vpc_init" {
  source = "./prod/components/vpc"
}

module "liferay_init" {
  source = "./dev/services/liferay"
}