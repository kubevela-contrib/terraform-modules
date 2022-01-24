locals {
  this_instance_id      = var.existing_instance_id != "" ? var.existing_instance_id : concat(alicloud_mongodb_instance.this.*.id, [""])[0]
  create_more_resources = var.existing_instance_id != "" || var.create ? true : false
}

resource "alicloud_mongodb_instance" "this" {
  count                = var.existing_instance_id != "" ? 0 : var.create ? 1 : 0
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
