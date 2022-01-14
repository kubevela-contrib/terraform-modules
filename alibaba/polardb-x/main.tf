module "vswitch" {
  source = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/vswitch"
}

# Some of the following HCl comes from https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc-slb-ecs-rds-drds

resource "alicloud_drds_instance" "default" {
  description          = var.description
  instance_charge_type = var.drds_instance_charge_type
  zone_id              = var.availability_zone
  vswitch_id           = module.vswitch.VSWITCH_ID
  instance_series      = var.drds_instance_series
  specification        = var.drds_specification
}

variable "availability_zone" {
  description = "The available zone to launch modules."
  type        = string
  default     = "cn-hangzhou-e"
}

variable "description" {
  description = "The specification of module description."
  type        = string
  default     = "tf-vpc-slb-ecs-rds-drds-description"
}

variable "drds_instance_charge_type" {
  description = "The instance charge type of DRDS."
  type        = string
  default     = "PostPaid"
}

variable "drds_instance_series" {
  description = "The instance series type of DRDS."
  type        = string
  default     = "drds.sn1.2c8g"
}

variable "drds_specification" {
  description = "The instance specification type of DRDS."
  type        = string
  default     = "drds.sn1.2c8g.2C8G"
}


output "ID" {
  value = resource.alicloud_drds_instance.default.id
}