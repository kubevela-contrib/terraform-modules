terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.156.0"
    }
  }
}

# namespace
resource "alicloud_sae_namespace" "default" {
  namespace_description = var.namespace_description
  namespace_id          = var.namespace_id
  namespace_name        = var.namespace_name
}

variable "namespace_description" {
  description = "Namespace Description"
  default     = "a namespace"
}

variable "namespace_name" {
  description = "Namespace Name"
  type = string
}

variable "namespace_id" {
  description = "Namespace ID"
  type = string
}

output "namespace_id" {
  value = var.namespace_id
  description = "Namespace ID"
}

# VPC and Security Group

resource "alicloud_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = module.vpc.VPC_ID
}

resource "alicloud_security_group_rule" "sg_rule" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = var.port_range
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = var.cidr_ip
}

module "vpc" {
  source  = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/vswitch"
  zone_id = var.zone_id
}

variable "name" {
  default     = "tf"
  description = "The name of the security group rule"
  type        = string
}

variable "description" {
  default     = "The description of the security group rule"
  description = "The description of the security group rule"
  type        = string
}

variable "port_range" {
  default     = "1/65535"
  description = "The port range of the security group rule"
  type        = string
}

variable "cidr_ip" {
  description = "cidr blocks used to create a new security group rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-hongkong-b"
}

# SAE

#resource "alicloud_sae_application" "manual" {
#  app_name          = var.name
#  deploy            = false
#  app_description   = local.default_description
#  namespace_id      = alicloud_sae_namespace.default.id
#  vswitch_id        = alicloud_vswitch.vsw.id
#  vpc_id            = alicloud_vpc.vpc.id
#  // vswitch_id = "${alicloud_vswitch.vsw.id},${alicloud_vswitch.vsw1.id}"
#  security_group_id = alicloud_security_group.group.id
#  image_url         = "registry-vpc.cn-hangzhou.aliyuncs.com/sae-demo-image/provider:1.0"
#
#  package_type = "Image"
#  timezone     = "Asia/Shanghai"
#  replicas     = var.replicas
#  cpu          = "500"
#  memory       = "2048"
#
#  #  intranet_slb_id = alicloud_slb_load_balancer.slb.id
#  #  intranet {
#  #    https_cert_id = ""
#  #    port = 80
#  #    protocol = "TCP"
#  #    target_port = 8080
#  #  }
#}

resource "alicloud_sae_application" "manual" {
  app_name          = var.app_name
  app_description   = var.app_description
  deploy            = false
  image_url         = var.image_url
  namespace_id      = alicloud_sae_namespace.default.id
  vswitch_id        = module.vpc.VSWITCH_ID
  vpc_id            = module.vpc.VPC_ID
  security_group_id = alicloud_security_group.sg.id
  package_type      = var.package_type
  timezone          = "Asia/Beijing"
  replicas          = var.replicas
  cpu               = var.cpu
  memory            = var.memory
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
  value       = alicloud_sae_application.manual.id
}

output "app_name" {
  description = "The name of the application"
  value       = var.app_name
}
