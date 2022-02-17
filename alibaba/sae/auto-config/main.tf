terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.156.0"
    }
  }
}

resource "random_uuid" "this" {}

locals {
  default_description = "Auto created by serverless devs with terraform"
  default_name = "terraform-test-${random_uuid.this.result}"
}

resource "alicloud_sae_application" "auto" {
  count = 1
  app_name = var.name
  app_description = local.default_description
  auto_config = true
  # image_url = "registry-vpc.cn-hangzhou.aliyuncs.com/sae-demo-image/provider:1.099"
  image_url = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"

  package_type = "Image"
  timezone = "Asia/Beijing"
  replicas = "1"
  cpu = "500"
  memory = "2048"
}

variable "name" {
  default = "dev"
}
