# This tells terraform to use a defined bucket and dynamodb table to manage state and locking
terraform {
  backend "s3" {
    bucket         = "n9n-s3-tf-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf_state_lock"
  }
}