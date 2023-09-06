resource "aws_dynamodb_table" "tf-state-lock" {
  name           = "tf_state_lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Dynamodb Terraform State Lock Table"
  }
}