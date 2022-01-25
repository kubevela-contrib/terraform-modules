resource "alicloud_vpc" "vpc" {
  count       = var.vpc_id != "" ? 0 : var.create_vpc ? 1 : 0
  vpc_name    = var.vpc_name
  cidr_block  = var.vpc_cidr
  description = var.vpc_description
}

resource "alicloud_vswitch" "vswitches" {
  vpc_id       = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  vswitch_name = var.vswitch_name
  cidr_block   = var.vswitch_cidr
  description  = var.vswitch_description
  zone_id      = var.zone_id
}


# MongoDB instance
module "alicloud_mongodb_instance" {
  # source = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/mongodb/instance"
  source = "../instance"

  engine_version       = var.engine_version
  name                 = var.name
  instance_charge_type = var.instance_charge_type
  db_instance_class    = var.db_instance_class
  db_instance_storage  = var.db_instance_storage
  period               = var.period
  security_ip_list     = var.security_ip_list
  replication_factor   = var.replication_factor
  storage_engine       = var.storage_engine
  vswitch_id           = var.vswitch_id
  zone_id              = var.zone_id
  account_password     = var.account_password
  backup_period        = var.backup_period
  backup_time          = var.backup_time
  tags                 = var.tags
}


## MongoDB account
#resource "alicloud_mongodb_account" "example" {
#  account_name        = "root"
#  account_password    = "example_value"
#  instance_id         = module.alicloud_mongodb_instance.DB_ID
#  account_description = "example_value"
#}


