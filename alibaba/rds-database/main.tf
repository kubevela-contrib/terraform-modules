locals {
  databases = [
    {
      "name" : var.database_name,
      "character_set" : "utf8",
      "description" : var.database_description
    },
  ]
}

module "rds" {
  source = "github.com/kubevela-contrib/terraform-alicloud-rds"

  create_instance            = false
  allocate_public_connection = false
  existing_instance_id       = var.existing_instance_id

  account_name = var.account_name
  password     = var.password
  databases    = local.databases
  privilege    = var.privilege
  region =  var.
}

#################
# Instance Output
#################
output "instance_id" {
  value       = module.rds.db_instance_id
  description = "RDS Instance ID"
}

#################
# Database Output
#################
output "database_id" {
  description = "Rds database id."
  value       = module.rds.this_db_database_id
}

output "database_user" {
  value       = module.rds.this_db_database_account
  description = "Database User"
}

output "database_password" {
  value       = var.password
  description = "Database Password"
}

output "database_name" {
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
variable "existing_instance_id" {
  description = "The Id of an existing RDS instance. If set, the `create_instance` will be ignored."
  default     = ""
}

#################
# Rds database account
#################
variable "account_name" {
  description = "RDS instance user account name"
  type        = string
}

variable "password" {
  description = "RDS instance account password"
  type        = string
}

variable "privilege" {
  description = "The privilege of one account access database."
  type        = string
  default     = "ReadWrite"
}

variable "database_name" {
  description = "Database name"
  type        = string
}

variable "database_description" {
  description = "description of database"
  type        = string
  default     = ""
}