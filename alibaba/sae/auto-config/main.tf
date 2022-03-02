terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.156.0"
    }
  }
}

resource "alicloud_sae_application" "auto" {
  count           = 1
  app_name        = var.app_name
  app_description = var.app_description
  auto_config     = true
  deploy          = true
  image_url       = var.image_url
  package_type    = var.package_type
  timezone        = "Asia/Beijing"
  replicas        = var.replicas
  cpu             = var.cpu
  memory          = var.memory
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "app_description" {
  default     = "description created by Terraform"
  description = "The description of the application"
  type        = string
}

variable "package_type" {
  default     = "Image"
  description = "The package type of the application"
  type        = string
}

variable "cpu" {
  default     = "500"
  description = "The cpu of the application, in unit of millicore"
  type        = string
}

variable "memory" {
  default     = "1024"
  description = "The memory of the application, in unit of MB"
  type        = string
}

variable "image_url" {
  description = "The image url of the application, like `registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9`"
  type        = string
}

variable "replicas" {
  default     = "1"
  description = "The replicas of the application"
  type        = string
}

output "app_id" {
  description = "The id of the application"
  value       = alicloud_sae_application.auto.0.id
}

output "app_name" {
  description = "The name of the application"
  value       = var.app_name
}
