terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.20.0"
    }
  }
}

locals {
  website_source = "website_source"
}

resource "null_resource" "default" {
  provisioner "local-exec" {
    command = <<EOF
apk update
apk add build-base libtool automake autoconf nasm pkgconfig util-linux git
rm -rf ${local.website_source}
git clone ${var.src_url} ${local.website_source}
cd ${local.website_source}
${var.prerequisite_cmd}
${var.build_cmd}
ossutil cp -r ${var.generated_dir} oss://${var.bucket} --access-key-id=$ALICLOUD_ACCESS_KEY --access-key-secret=$ALICLOUD_SECRET_KEY --endpoint=${var.endpoint} --force
    EOF
  }
}

variable "bucket" {
  description = "OSS bucket name"
  type        = string
  default     = "vela-deploy-website-example"
}

variable "endpoint" {
  description = "OSS bucket endpoint"
  type        = string
  default     = "oss-cn-hangzhou.aliyuncs.com"
}

variable "src_url" {
  description = "The URL of the website source code repository"
  type    = string
  default = "https://github.com/open-gitops/website.git"
}

variable "prerequisite_cmd" {
  description = "Prerequisite commands to setup building env, support Alpine `apk` package manager"
  type    = string
  default = "apk add nodejs npm && npm install --global yarn"
}

variable "build_cmd" {
  description = "Commands for building website source code"
  type    = string
  default = "yarn install && yarn build"
}

variable "generated_dir" {
  description = "Directory name of generated static content"
  type    = string
  default = "public"
}

output "URL" {
  description = "The URL of the website"
  value       = "https://${var.bucket}.${var.endpoint}"
}
