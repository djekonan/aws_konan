resource "aws_s3_bucket" "example" {
  count = var.example_count
  bucket = "my-tf-test-bucket"
  force_destroy = false
  acl    = "private"

  tags = {
    Name        = "test-bucket-${count.index}"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "versioning_example" {
  count  = var.example_count
  bucket = aws_s3_bucket.example[count.index].id
  versioning_configuration {
    status = "Disabled"
  }
}


resource "aws_s3_bucket_object_lock_configuration" "example" {
  count  = var.example_count
  bucket = aws_s3_bucket.example[count.index].id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}
