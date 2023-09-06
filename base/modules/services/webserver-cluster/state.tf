# Use the backend named s3 to store state
# The key value separates it from other components
#terraform {
#  backend "s3" {
#    key            = "stage/services/webserver-cluster/terraform.tfstate"
#    bucket         = "n9n-s3-state-220523"
#    region         = "us-east-1"
#    dynamodb_table = "tf_state_lock"
#    encrypt        = "true"
#  }
#}