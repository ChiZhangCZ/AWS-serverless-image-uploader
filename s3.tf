resource "random_string" "random" {
  length = 16
  special = true
  override_special = "/@£$"
  upper = false
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "s3-image-store-${random_string.random.result}"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}