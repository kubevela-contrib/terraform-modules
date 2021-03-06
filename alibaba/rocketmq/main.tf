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
  ids            = [alicloud_ons_instance.default.id]
  name_regex     = alicloud_ons_instance.default.name
  enable_details = true
}

variable "ons_instance_name" {
  description = "The name of ons instance. The length must be 3 to 64 characters. Chinese characters, English letters digits and hyphen are allowed."
  type        = string
  default     = "tf-vela"
}

variable "topic" {
  description = "The specification of ons topic name. Two topics on a single instance cannot have the same name and the name cannot start with 'GID' or 'CID'. The length cannot exceed 64 characters."
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
  description = "The type of the message. Read [Ons Topic Create](https://www.alibabacloud.com/help/doc-detail/29591.html) for further details."
  type        = number
}

variable "group_name" {
  default     = "GID-example"
  description = "The name of MQ group"
  type        = string
}

variable "group_type" {
  default     = "tcp"
  description = "Specify the protocol applicable to the created Group ID. Valid values: tcp, http. Default to tcp"
  type        = string
}

variable "perm" {
  default     = 6
  description = "The permission of MQ topic"
  type        = string
}

output "INSTANCE_ID" {
  value       = alicloud_ons_instance.default.id
  description = "The id of ons instance"
}

output "TOPIC_ID" {
  value       = alicloud_ons_topic.default.id
  description = "The id of ons topic"
}

output "GROUP_ID" {
  value       = alicloud_ons_group.default.id
  description = "The id of ons group"
}

output "HTTP_ENDPOINT_INTERNET" {
  value       = data.alicloud_ons_instances.default.instances.0.http_internet_endpoint
  description = "The internet http endpoint of ons instance"
}

output "HTTP_ENDPOINT_INTERNAL" {
  value       = data.alicloud_ons_instances.default.instances.0.http_internal_endpoint
  description = "The internal http endpoint of ons instance"
}

output "TCP_ENDPOINT" {
  value       = data.alicloud_ons_instances.default.instances.0.tcp_endpoint
  description = "The tcp endpoint of ons instance"
}
