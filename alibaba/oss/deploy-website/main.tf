terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.20.0"
    }
  }
}

locals {
  website_source = "static"
}

resource "null_resource" "default" {

  provisioner "local-exec" {
    command = "rm -rf ${local.website_source} && git clone ${var.static_web_url} ${local.website_source} && ossutil cp -r ${local.website_source} oss://${var.bucket} --access-key-id=$ALICLOUD_ACCESS_KEY --access-key-secret=$ALICLOUD_SECRET_KEY --endpoint=${var.endpoint} --force"

  }
}

variable "static_web_url" {
  description = "The URL of the static website"
  type = string
  default = "https://github.com/cloudacademy/static-website-example.git"
}


variable "bucket" {
  description = "OSS bucket name"
  default = "vela-website"
  type = string
}

variable "endpoint" {
  description = "OSS bucket endpoint"
  type = string
}

variable "index_document" {
  description = "OSS bucket static website index document"
  default     = "index.html"
  type        = string
}

output "URL" {
  value = "https://${var.bucket}.${var.endpoint}/${var.index_document}"
}