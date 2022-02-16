terraform {
  required_providers {
    baiducloud = {
      source  = "baidubce/baiducloud"
      version = "1.12.0"
    }
  }
}

resource "baiducloud_subnet" "default" {
  name      = var.subnet_name
  zone_name = var.zone_name
  cidr      = var.subnet_cidr
  vpc_id    = var.vpc_id
}

variable "subnet_name" {
  default = "terraform-subnet"
}

variable "zone_name" {
  description = "zone id"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "subnet_cidr" {
  description = "The CIDR of the VPC"
  default     = "192.168.1.0/24"
  type        = string
}