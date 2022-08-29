terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.20.0"
    }
  }
}

resource "null_resource" "default" {
  provisioner "local-exec" {
    command = <<EOF
apk update
apk add build-base libtool automake autoconf nasm pkgconfig util-linux git
rm -rf ${var.src_folder}
git clone ${var.src_url}
cd ${var.src_folder}
${var.prepare_build_env_cmd}
${var.build_cmd}
ossutil cp -r ${var.dst_folder} oss://${var.bucket} --access-key-id=$ALICLOUD_ACCESS_KEY --access-key-secret=$ALICLOUD_SECRET_KEY --endpoint=${var.endpoint} --force
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
  description = "Source code repo on GitHub"
  type    = string
  default = "https://github.com/kubevela/kubevela.io.git"
}

variable "src_folder" {
  description = "Source code root folder path"
  type    = string
  default = "kubevela.io/"
}

variable "prepare_build_env_cmd" {
  description = "Required commands for prepare build env"
  type    = string
  default = "apk add nodejs npm && npm install --global yarn"
}

variable "build_cmd" {
  description = "Commands for build source code"
  type    = string
  default = "yarn install && yarn build"
}

variable "dst_folder" {
  description = "Building output folder path"
  type    = string
  default = "build/"
}

output "URL" {
  description = "The URL of the website"
  value       = "https://${var.bucket}.${var.endpoint}"
}
