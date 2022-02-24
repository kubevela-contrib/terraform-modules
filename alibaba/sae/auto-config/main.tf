terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.153.0"
    }
  }
}

locals {
  default_description = "Auto created by serverless devs with terraform"
}

resource "alicloud_sae_application" "auto" {
  count           = 1
  app_name        = var.name
  app_description = local.default_description
  auto_config     = true
  # image_url = "registry-vpc.cn-hangzhou.aliyuncs.com/sae-demo-image/provider:1.099"
  image_url       = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"

  package_type = "Image"
  timezone     = "Asia/Beijing"
  replicas     = "1"
  cpu          = "500"
  memory       = "1024"
  deploy       = true
}

variable "name" {
  default = "dev"
}
