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

data "alicloud_amqp_queues" "ids" {
  instance_id       = alicloud_amqp_instance.default.0.id
  virtual_host_name = alicloud_amqp_virtual_host.default.id
}

output "QUEUE_ID" {
  value = alicloud_amqp_queue.default.id
  description = "Queue ID"
}

output "QUEUE_NAME" {
  value = var.name
  description = "Queue Name"
}

output "VIRTUAL_HOST_NAME" {
  description = "Virtual Host Name"
  value = alicloud_amqp_virtual_host.default.virtual_host_name
}

output "EXCHANGE_TYPE" {
  value = var.exchange_type
  description = "Exchange Type"
}