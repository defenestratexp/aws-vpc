# Define a KMS key to encrypt S3 buckets
resource "aws_kms_key" "s3-kms-key" {
  description = "Use this key to encrypt S3 buckets"
}

# Define an S3 bucket which will hold terraform state
resource "aws_s3_bucket" "s3-tf-bucket" {
  bucket = "n9n-s3-state-220523"

  # Set lifecycle to prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name        = "S3 Remote Terraform State Bucket"
    Environment = "Prod"
  }
}

# Enable versioning on the state bucket
resource "aws_s3_bucket_versioning" "s3-tf-bucket-versioning" {
  bucket = aws_s3_bucket.s3-tf-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption, using KMS, on the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "s3-sse-config" {
  bucket = aws_s3_bucket.s3-tf-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3-kms-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Explicitly block all public bucket access
resource "aws_s3_bucket_public_access_block" "s3-pub-block" {
  bucket                  = aws_s3_bucket.s3-tf-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Set the s3 bucket to private
resource "aws_s3_bucket_acl" "s3-tf-state-bucket-acl" {
  bucket = aws_s3_bucket.s3-tf-bucket.id
  acl    = "private"
}