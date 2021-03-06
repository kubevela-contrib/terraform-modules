# Configure the terraform provider
terraform {
  required_providers {
    ucloud = {
      source  = "ucloud/ucloud"
      version = "~>1.29.0"
    }
  }
}
# Configure the UCloud Provider
# Document: https://registry.terraform.io/providers/ucloud/ucloud/latest/docs/resources/redis_instance
provider "ucloud" {
  base_url = "http://api.service.ucloud.cn"
  region   = "cn-bj2"
}

# Create redis instance
resource "ucloud_redis_instance" "example" {
  availability_zone = var.zone
  instance_type     = var.instance_type
  name              = var.name
  tag               = "ADDON_REDIS"
  password          = var.password
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  engine_version    = var.engine_version
  auto_backup       = var.auto_backup
  backup_begin_time = var.backup_begin_time
  charge_type       = var.charge_type
  #standby_zone
  #duration
}

# output
output "REDIS_INSTANCE_ID" {
  description = "The Ucloud Redis InstancdID"
  value       = ucloud_redis_instance.addon_redis.id
}
output "REDIS_IP" {
  description = "The Ucloud Redis Private IP"
  value       = ucloud_redis_instance.addon_redis.ip_set[0].ip
}
output "REDIS_PORT" {
  value = "6379"
  # https://github.com/oam-dev/terraform-controller/issues/141
  #value = ucloud_redis_instance.addon_redis.ip_set[0].port
}
output "REDIS_PASSWORD" {
  value = var.password
}
output "REDIS_NAME" {
  value = var.name
}
output "REDIS_STATUS" {
  value = ucloud_redis_instance.addon_redis.status
}
output "AUTO_BACKUP" {
  value = var.auto_backup
}

# variables
variable "zone" {
  description = "Refer to https://docs.ucloud.cn/api/summary/regionlist"
}
variable "instance_type" {
  type        = string
  default     = "redis-master-2"
  description = "See https://docs.ucloud.cn/terraform/specification/umem_instance?id=redis"
}
variable "name" {
  type = string
}
variable "vpc_id" {
  description = "The ID of VPC linked to the Redis instance."
  default     = ""
}
variable "subnet_id" {
  description = "The ID of subnet linked to the Redis instance."
  default     = ""
}
variable "engine_version" {
  description = "The version of engine of active-standby Redis. Possible values are: 4.0, 5.0 and 6.0."
  default     = "5.0"
}
# uredis 5.0 ignores username
#variable "username" {
#  type = string
#  default = "admin"
#}
variable "password" {
  description = "Redis instance account password"
  type        = string
}
variable "auto_backup" {
  type        = string
  default     = "disable"
  description = "Auto backup of Redis instance,(only Active-Standby): enable, disable"
}
variable "backup_begin_time" {
  type        = number
  default     = 3
  description = "When the backup starts(hour): 0-23"
}
variable "charge_type" {
  type        = string
  default     = "dynamic"
  description = "The charge type of Redis instance: year|month|dynamic"
}
