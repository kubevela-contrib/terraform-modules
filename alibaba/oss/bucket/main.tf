locals {
  website =  var.index_document != ""?{
    index_document = "index.html"
    error_document = "error.html"
  }:{}
}

resource "alicloud_oss_bucket" "bucket-acl" {
  bucket = var.bucket
  acl = var.acl

}

output "BUCKET_NAME" {
  value = var.bucket
}

variable "bucket" {
  description = "OSS bucket name"
  default = "vela-website"
  type = string
}

variable "acl" {
  description = "OSS bucket ACL, supported 'private', 'public-read', 'public-read-write'"
  default = "private"
  type = string
}

variable "index_document" {
  description = "OSS bucket static website index document"
  default = ""
  type = string
}

variable "error_document" {
  description = "OSS bucket static website error document"
  default = "error.html"
  type = string
}

output "EXTERNAL_ENDPOINT" {
  value = alicloud_oss_bucket.bucket-acl.extranet_endpoint
  description = "OSS bucket external endpoint"
}

output "INTRANE_ENDPOINT" {
  value = alicloud_oss_bucket.bucket-acl.intranet_endpoint
  description = "OSS bucket internal endpoint"
}
