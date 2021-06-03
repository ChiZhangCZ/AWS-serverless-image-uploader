resource "aws_s3_bucket" "upload_bucket" {
  bucket = "s3-image-store"
  ACL    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}