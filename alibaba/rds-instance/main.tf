module "rds" {
  source                     = "github.com/kubevela-contrib/terraform-alicloud-rds"
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_type              = var.instance_type
  instance_storage           = var.instance_storage
  instance_name              = var.instance_name
  allocate_public_connection = var.allocate_public_connection
  security_ips               = var.security_ips
  vswitch_id                 = var.vswitch_id
  region                     = var.region
  create_account             = false
  create_database            = false
}

output "instance_id" {
  value       = module.rds.db_instance_id
  description = "RDS Instance ID"
}

output "instance_name" {
  value       = module.rds.this_db_instance_name
  description = "RDS Instance Name"
}

output "instance_port" {
  value       = module.rds.this_db_instance_port
  description = "RDS Instance Port"
}

output "instance_connection_string" {
  value       = module.rds.this_db_instance_connection_string
  description = "RDS Instance Host"
}

output "instance_public_connection_string" {
  value       = module.rds.db_public_connection_string
  description = "RDS Instance Public Host"
}

#################
# Provider
#################
variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

#################
# Rds Instance
#################
variable "instance_name" {
  description = "RDS instance name"
  type        = string
}

variable "instance_type" {
  description = "DB Instance type, for example: mysql.n1.micro.1. full list is : https://www.alibabacloud.com/help/zh/doc-detail/26312.htm"
  type        = string
  default     = "rds.mysql.c1.large"
}

variable "engine" {
  description = "RDS Database type. Value options: MySQL, SQLServer, PostgreSQL, and PPAS"
  type        = string
  default     = "MySQL"
}

variable "engine_version" {
  description = "RDS Database version. Value options can refer to the latest docs [CreateDBInstance](https://www.alibabacloud.com/help/doc-detail/26228.htm) `EngineVersion`"
  type        = string
  default     = "8.0"
}

variable "instance_storage" {
  description = "The storage capacity of the instance. Unit: GB. The storage capacity increases at increments of 5 GB. For more information, see [Instance Types](https://www.alibabacloud.com/help/doc-detail/26312.htm)."
  type        = number
  default     = 20
}

variable "security_ips" {
  description = "List of IP addresses allowed to access all databases of an instance"
  type        = list(any)
  default     = ["0.0.0.0/0",]
}

variable "vswitch_id" {
  type        = string
  description = "The vswitch id of the RDS instance. If set, the RDS instance will be created in VPC, or it will be created in classic network."
  default     = ""
}

#################
# Rds Connection
#################
variable "allocate_public_connection" {
  description = "Whether to allocate public connection for a RDS instance."
  type        = bool
  default     = true
}
