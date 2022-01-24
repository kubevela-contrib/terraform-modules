locals {
  amqp_instance_id = var.instance_id != "" ? var.instance_id : concat(alicloud_amqp_instance.default.*.id, [""])[0]
}
