# Global Outputs file

# STATE
# S3 state bucket
output "s3_bucket_arn" {
  value       = aws_s3_bucket.s3-tf-bucket.arn
  description = "The ARN of the S3 state bucket"
}

# DynamoDB table used for state locking
output "dynamodb_state_table" {
  value       = aws_dynamodb_table.tf-state-lock.name
  description = "The name of the DynamoDB table"
}