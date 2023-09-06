# Deploy infra to support a Liferay Installation

# Dev Liferay
module "liferay" {
  source                = "../../../modules/services/liferay"
  env                   = var.env
  aws_region            = var.region
  dev_group_min         = var.dev_group_min
  dev_group_max         = var.dev_group_max
  image_id              = var.image_id
  liferay_instance_type = "t3.large"
  server_port           = var.server_port
}