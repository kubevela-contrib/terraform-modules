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
  vpc_id            = alicloud_vpc.vpc.id
  vswitch_id        = alicloud_vswitch.vsw.id
  security_group_id = alicloud_security_group.group.id
  image_url         = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"

  package_type = "Image"
  timezone     = "Asia/Shanghai"
  replicas     = "1"
  cpu          = "500"
  memory       = "2048"

#  intranet_slb_id = alicloud_slb_load_balancer.slb.id
#  intranet {
#    https_cert_id = ""
#    port          = 8000
#    protocol      = "TCP"
#    target_port   = 80
#  }

    internet_slb_id = alicloud_slb_load_balancer.slb.id
    internet {
      https_cert_id = ""
      port = var.port
      protocol = "HTTP"
      target_port = 80
    }


  //    [{"httpsCertId":"","port":80,"protocol":"TCP","targetPort":8080}]

  //  min_ready_instances = 1
  //  batch_wait_time = 10
  //  update_strategy = <<EOF
  //    {
  //        "type": "GrayBatchUpdate",
  //        "batchUpdate": {
  //            "batch": 1,
  //            "releaseType": "auto",
  //            "batchWaitTime": 1
  //        },
  //        "grayUpdate": {
  //            "gray": 1
  //        }
  //    }
  //  EOF
  //
  //  config_map_mount_desc = <<EOF
  //       [{"configMapId":"${alicloud_sae_config_map.cm.id}","key":"env.shell","mountPath":"/tmp"}]
  //    EOF
}

resource "alicloud_sae_namespace" "default" {
  namespace_description = local.default_description
  namespace_id          = "cn-hangzhou:demo123"
  namespace_name        = local.default_name
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

resource "alicloud_slb_load_balancer" "slb" {
  load_balancer_name = local.default_name
  address_type       = "internet"
  load_balancer_spec = "slb.s2.small"
  vswitch_id         = alicloud_vswitch.vsw.id
  tags               = {
    info = "create for internet"
  }
}

resource "alicloud_security_group" "group" {
  name   = local.default_name
  vpc_id = alicloud_vpc.vpc.id
}


variable "name" {
  default = "slb-access"
}

variable "port" {
  default = "8000"
}

output "endpoint" {
  value = format("http://%s:%s", alicloud_slb_load_balancer.slb.address, var.port)
}
