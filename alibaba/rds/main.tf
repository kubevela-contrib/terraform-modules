locals {
  databases = [
    {
      "name" : var.database_name,
      "character_set" : "utf8",
      "description" : "test database"
    },
  ]
}

module "rds" {
  source                     = "github.com/kubevela-contrib/terraform-alicloud-rds"
  engine                     = "MySQL"
  engine_version             = "8.0"
  instance_type              = "rds.mysql.c1.large"
  instance_storage           = "20"
  instance_name              = var.instance_name
  account_name               = var.account_name
  password                   = var.password
  allocate_public_connection = var.allocate_public_connection
  security_ips               = var.security_ips
  databases                  = length(var.databases) != 0 ? var.databases: local.databases

  privilege  = var.privilege
  vswitch_id = var.vswitch_id
}

#resource "null_resource" "default" {
#  depends_on = [
#    module.rds
#  ]
#
#  provisioner "local-exec" {
#    command = var.sql_file != "" ? "ossutil cp -r ${var.sql_bucket_name}/${var.sql_file} . --access-key-id=$ALICLOUD_ACCESS_KEY --access-key-secret=$ALICLOUD_SECRET_KEY --endpoint=${var.sql_bucket_endpoint} && mysql -h ${module.rds.db_public_connection_string} -u ${module.rds.this_db_database_account} \"-p${var.password}\" -D ${var.database_name} < ./${var.sql_file}" : "date"
#
#  }
#}

output "RESOURCE_IDENTIFIER" {
  description = "The identifier of the resource"
  value       = module.rds.db_instance_id
}

output "DB_ID" {
  value       = module.rds.db_instance_id
  description = "RDS Instance ID"
}

output "DB_NAME" {
  value       = module.rds.this_db_instance_name
  description = "RDS Instance Name"
}
output "DB_USER" {
  value       = module.rds.this_db_database_account
  description = "RDS Instance User"
}
output "DB_PORT" {
  value       = module.rds.this_db_instance_port
  description = "RDS Instance Port"
}
output "DB_HOST" {
  value       = module.rds.this_db_instance_connection_string
  description = "RDS Instance Host"
}
output "DB_PASSWORD" {
  value       = var.password
  description = "RDS Instance Password"
}
output "DB_PUBLIC_HOST" {
  value       = module.rds.db_public_connection_string
  description = "RDS Instance Public Host"
}

output "DATABASE_NAME" {
  value       = module.rds.this_db_database_name
  description = "RDS Database Name"
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
  default     = "poc"
}

variable "account_name" {
  description = "RDS instance user account name"
  type        = string
  default     = "oam"
}

variable "password" {
  description = "RDS instance account password"
  type        = string
}

variable "security_ips" {
  description = "List of IP addresses allowed to access all databases of an instance"
  type        = list(any)
  default     = ["0.0.0.0/0",]
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "dblinks"
}

variable "privilege" {
  description = "The privilege of one account access database."
  type        = string
  default     = "ReadWrite"
}

#variable "sql_file" {
#  description = "The name of SQL file in the bucket, like `db.sql`"
#  type        = string
#  default     = ""
#}
#
#variable "sql_bucket_name" {
#  description = "The bucket name of the SQL file. like `oss://example`"
#  type        = string
#  default     = ""
#}
#
#variable "sql_bucket_endpoint" {
#  description = "The endpoint of the bucket. like `oss-cn-hangzhou.aliyuncs.com`"
#  type        = string
#  default     = ""
#}

variable "vswitch_id" {
  type        = string
  description = "The vswitch id of the RDS instance. If set, the RDS instance will be created in VPC, or it will be created in classic network."
  default     = ""
}

variable "databases" {
  description = "The database list, each database is a map, the map contains the following attributes: name, character_set, description, like `[{\"name\":\"test\",\"character_set\":\"utf8\",\"description\":\"test database\"},]`. It conflicts with `database_name`."
  type = list(map(string))
  default = []
}

#################
# Rds Connection
#################
variable "allocate_public_connection" {
  description = "Whether to allocate public connection for a RDS instance."
  type        = bool
  default     = true
}