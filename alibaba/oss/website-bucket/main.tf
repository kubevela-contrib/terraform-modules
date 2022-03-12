resource "alicloud_oss_bucket" "bucket-acl" {
  bucket = var.bucket
  acl    = var.acl

  website {
    index_document = var.index_document
    error_document = var.error_document
  }
}

variable "bucket" {
  description = "OSS bucket name"
  default     = "vela-website"
  type        = string
}

variable "acl" {
  description = "OSS bucket ACL, supported 'private', 'public-read', 'public-read-write'"
  default     = "private"
  type        = string
}

variable "index_document" {
  description = "OSS bucket static website index document"
  default     = "index.html"
  type        = string
}

variable "error_document" {
  description = "OSS bucket static website error document"
  default     = "error.html"
  type        = string
}

output "BUCKET_NAME" {
  value = var.bucket
}

output "EXTRANET_ENDPOINT" {
  value       = alicloud_oss_bucket.bucket-acl.extranet_endpoint
  description = "OSS bucket external endpoint"
}

output "INTRANET_ENDPOINT" {
  value       = alicloud_oss_bucket.bucket-acl.intranet_endpoint
  description = "OSS bucket internal endpoint"
}

