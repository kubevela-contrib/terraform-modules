resource "alicloud_ons_instance" "default" {
  instance_name = var.ons_instance_name
  remark        = var.ons_instance_remark
}

resource "alicloud_ons_topic" "default" {
  topic_name   = var.topic
  instance_id  = alicloud_ons_instance.default.id
  message_type = var.message_type
  remark       = var.ons_topic_remark
  perm         = var.perm
}

resource "alicloud_ons_group" "default" {
  group_name  = var.group_name
  instance_id = alicloud_ons_instance.default.id
  remark      = "dafault_ons_group_remark"
  group_type  = var.group_type
}

data "alicloud_ons_instances" "default" {
  ids         = [alicloud_ons_instance.default.id]
  name_regex  = alicloud_ons_instance.default.name
}

variable "ons_instance_name" {
  description = "The specification of ons instance name."
  type        = string
  default     = "tf-onsInstanceName123"
}

variable "topic" {
  description = "The specification of ons topic name."
  type        = string
  default     = "onsTopicName1"
}

variable "ons_instance_remark" {
  description = "The specification of ons instance remark."
  type        = string
  default     = "tf-ons_instance_remark"
}

variable "ons_topic_remark" {
  description = "The specification of ons topic remark."
  type        = string
  default     = "tf-ons_topic_remark"
}

variable "message_type" {
  default     = 0
  description = "The type of the message"
  type        = number
}

variable "group_name" {
  default     = "GID-example"
  description = "The name of MQ group"
  type        = string
}

variable "group_type" {
  default     = "tcp"
  description = "The type of MQ group"
  type        = string
}

variable "perm" {
  default     = 6
  description = "The permission of MQ topic"
  type        = string
}

output "INSTANCE_ID" {
  value = alicloud_ons_instance.default.id
}

output "TOPIC_ID" {
  value = alicloud_ons_topic.default.id
}

output "GROUP_ID" {
  value = alicloud_ons_group.default.id
}

output "HTTP_ENDPOINT_INTERNET" {
  value = data.alicloud_ons_instances.default.instances.0.http_internet_endpoint
}

output "HTTP_ENDPOINT_INTERNAL" {
  value = data.alicloud_ons_instances.default.instances.0.http_internal_endpoint
}

output "TCP_ENDPOINT" {
  value = data.alicloud_ons_instances.default.instances.0.tcp_endpoint
}

output "xxx" {
  value = data.alicloud_ons_instances.default.instances
}

