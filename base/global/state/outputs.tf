# Outputs for global state management

# Verifying remote state
output "state_bucket_arn" {
  value       = aws_s3_bucket.s3-tf-bucket.arn
  description = "The ARN of the S3 bucket holding state"
}

output "state_dynamo" {
  value       = aws_dynamodb_table.tf-state-lock.name
  description = "The name of the DynamoDB table holding state"
}