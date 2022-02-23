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
  default_name        = "terraform-test-${random_uuid.this.result}"
}

resource "alicloud_sae_application" "manual" {
  app_name          = var.name
  deploy            = false
  app_description   = local.default_description
  namespace_id      = alicloud_sae_namespace.default.id
  vswitch_id        = alicloud_vswitch.vsw.id
  vpc_id            = alicloud_vpc.vpc.id
  // vswitch_id = "${alicloud_vswitch.vsw.id},${alicloud_vswitch.vsw1.id}"
  security_group_id = alicloud_security_group.group.id
  image_url       = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"

  package_type = "Image"
  timezone     = "Asia/Shanghai"
  replicas     = var.replicas
  cpu          = "500"
  memory       = "2048"

  config_map_mount_desc = <<EOF
        [{"configMapId":${alicloud_sae_config_map.default.id},"key":"env.shell","mountPath":"/tmp/abc"}]
     EOF
}

resource "alicloud_sae_namespace" "default" {
  namespace_description = local.default_description
  namespace_id          = "cn-hangzhou:demo"
  namespace_name        = local.default_name
}

resource "alicloud_sae_config_map" "default" {
  data         = jsonencode({ "env.home" : "/root", "env.shell" : "/bin/sh" })
  name         = var.ConfigMapName
  namespace_id = alicloud_sae_namespace.default.namespace_id
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = local.default_name
  cidr_block = "172.16.0.0/12"
}
data "alicloud_zones" "default" {}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

#resource "alicloud_slb_load_balancer" "slb" {
#  load_balancer_name = local.default_name
#  address_type       = "intranet"
#  load_balancer_spec = "slb.s2.small"
#  vswitch_id         = alicloud_vswitch.vsw.id
#  tags = {
#    info = "create for internet"
#  }
#}

resource "alicloud_security_group" "group" {
  name   = local.default_name
  vpc_id = alicloud_vpc.vpc.id
}


variable "name" {
  default = "manual"
}

variable "replicas" {
  default = 1
}

variable "ConfigMapName" {
  default = "examplename"
}