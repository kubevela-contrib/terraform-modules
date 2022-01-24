data "alicloud_mongodb_instances" "this" {
  ids = var.existing_instance_id != "" ? [var.existing_instance_id] : null
}
locals {
    this_db_instance_name                = var.existing_instance_id != "" ? concat(data.alicloud_mongodb_instances.this.instances.*.name, [""])[0] : concat(alicloud_mongodb_instance.this.*.name, [""])[0]
}
#################
# MongoDB Instance
#################
output "DB_ID" {
  description = "The ID of the MongoDB instance."
  value       = local.this_instance_id
}

output "DB_NAME" {
  description = "The name of MongoDB instance."
  value       = local.this_db_instance_name
}

output "DB_ROOT_PASSWORD" {
  sensitive = true
  value = var.account_password
  description = "The password of MongoDB instance."
}
