data "alicloud_mongodb_instances" "this" {
  ids = var.existing_instance_id != "" ? [var.existing_instance_id] : null
}
locals {
  this_db_instance_name = var.existing_instance_id != "" ? concat(data.alicloud_mongodb_instances.this.instances.*.name, [""])[0] : concat(alicloud_mongodb_instance.this.*.name, [""])[0]
  replica_sets          = alicloud_mongodb_instance.this.0.replica_sets
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

output "DB_USER" {
  description = "The username of MongoDB instance."
  value       = "root"
}

output "DB_PASSWORD" {
  sensitive   = true
  value       = var.account_password
  description = "The password of MongoDB instance."
}

output "DB_HOST" {
  description = "The connection address of the node."
  value       = format("mongodb://root:%s@%s:%d,%s:%d/admin?replicaSet=%s",var.account_password ,local.replica_sets.0.connection_domain,local.replica_sets.0.connection_port,local.replica_sets.1.connection_domain,local.replica_sets.1.connection_port,alicloud_mongodb_instance.this.0.replica_set_name)
}

output "DB_PORT" {
  value = local.replica_sets.0.connection_port
  description = "The port of the instance."
}

output "DB_REPLICA_SET_NAME" {
  value = alicloud_mongodb_instance.this.0.replica_set_name
}