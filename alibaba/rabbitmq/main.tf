# Modified from https://github.com/terraform-alicloud-modules/terraform-alicloud-rabbitmq

resource "alicloud_amqp_instance" "default" {
  count                 = var.instance_id != "" ? 0 : var.create ? 1 : 0
  instance_name         = var.name
  instance_type         = var.instance_type
  max_tps               = var.max_tps
  queue_capacity        = var.queue_capacity
  support_eip           = var.support_eip
  max_eip_tps           = var.max_eip_tps
  payment_type          = var.payment_type
  period                = var.period
}

resource "alicloud_amqp_virtual_host" "default" {
  instance_id       = local.amqp_instance_id
  virtual_host_name = var.name
}

resource "alicloud_amqp_queue" "default" {
  instance_id       = local.amqp_instance_id
  queue_name        = var.name
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
}

resource "alicloud_amqp_exchange" "default" {
  auto_delete_state = var.auto_delete_state
  exchange_name     = var.name
  exchange_type     = var.exchange_type
  instance_id       = alicloud_amqp_virtual_host.default.instance_id
  internal          = var.internal
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
}

resource "alicloud_amqp_binding" "default" {
  argument          = var.argument
  binding_key       = alicloud_amqp_queue.default.queue_name
  binding_type      = var.binding_type
  destination_name  = alicloud_amqp_queue.default.queue_name
  instance_id       = alicloud_amqp_exchange.default.instance_id
  source_exchange   = alicloud_amqp_exchange.default.exchange_name
  virtual_host_name = alicloud_amqp_exchange.default.virtual_host_name
}
