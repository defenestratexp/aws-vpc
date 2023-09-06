terraform {
  backend "s3" {
    key            = "stage/components/data-stores/mysql/terraform.tfstate"
    bucket         = "n9n-s3-state-220523"
    region         = "us-east-1"
    dynamodb_table = "tf_state_lock"
    encrypt        = true
  }
}