provider "aws" {
  region = "us-east-1"
}

# Simple S3 bucket with your unique ID
resource "aws_s3_bucket" "lab_bucket" {
  bucket = "terraform-ci-lab-${var.your_id4}"
  
  tags = {
    Project = "lab9"
    Owner   = var.your_id4
  }
}

# Add lifecycle to prevent accidental deletion
resource "aws_s3_bucket_lifecycle_configuration" "lab_bucket" {
  bucket = aws_s3_bucket.lab_bucket.id

  rule {
    id     = "auto-delete-after-7-days"
    status = "Enabled"

    expiration {
      days = 7
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "lab_bucket" {
  bucket = aws_s3_bucket.lab_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
