# This tells terraform to use a defined bucket and dynamodb table to manage state and locking
terraform {
  backend "s3" {
    key = "global/s3/terraform.tfstate"
  }
}