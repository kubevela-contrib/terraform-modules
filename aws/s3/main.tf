resource "aws_s3_bucket" "bucket-acl" {
  bucket = var.bucket
  acl    = var.acl
}

output "BUCKET_NAME" {
  value = aws_s3_bucket.bucket-acl.bucket_domain_name
}

variable "bucket" {
  description = "S3 bucket name"
  default     = "vela-website"
  type        = string
}

variable "acl" {
  description = "S3 bucket ACL"
  default     = "private"
  type        = string
}
