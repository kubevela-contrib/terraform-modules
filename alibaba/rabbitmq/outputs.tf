output "INSTANCE_ID" {
  value = var.instance_id != "" ? var.instance_id : concat(alicloud_amqp_instance.default.*.id, [""])[0]
  description = "Instance ID"
}

output "INSTANCE_NAME" {
  value = var.instance_id != "" ? var.instance_id : concat(alicloud_amqp_instance.default.*.instance_name, [""])[0]
  description = "Instance Name"
}

data "alicloud_amqp_instances" "default" {
  ids = alicloud_amqp_instance.default.*.id
  enable_details = true
}

output "PUBLIC_ENDPOINT" {
  value = data.alicloud_amqp_instances.default.instances.0.public_endpoint
  description = "Public endpoint of the instance"
}

output "PRIVATE_ENDPOINT" {
  value = data.alicloud_amqp_instances.default.instances.0.private_end_point
  description = "Private endpoint of the instance"
}

