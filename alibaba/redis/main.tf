module "redis" {
  source               = "github.com/chivalryq/terraform-alicloud-redis"
  engine_version       = "5.0"
  instance_name        = var.instance_name
  instance_class       = "redis.master.mid.default"
  period               = 1
  instance_charge_type = "PostPaid"

  #################
  # Redis Accounts
  #################

  accounts = [
    {
      account_name      = var.account_name
      account_password  = var.password
      account_privilege = "RoleReadWrite"
      account_type      = "Normal"
    },
  ]

  #################
  # Redis backup_policy
  #################

  backup_policy_backup_time   = "02:00Z-03:00Z"
  backup_policy_backup_period = ["Monday", "Wednesday", "Friday"]

}

output "RESOURCE_IDENTIFIER" {
  description = "The identifier of the resource"
  value       = module.redis.this_redis_instance_id
}

output "REDIS_NAME" {
  value       = module.redis.this_redis_instance_name
  description = "Redis instance name"
}

output "REDIS_CONNECT_ADDRESS" {
  value       = format("%s.%s", module.redis.this_redis_instance_id, "redis.rds.aliyuncs.com")
  description = "Redis connect address"
}

output "REDIS_USER" {
  value       = module.redis.this_redis_instance_account_name
  description = "Redis user"
}

output "REDIS_PASSWORD" {
  value       = var.password
  sensitive   = true
  description = "Redis password"
}

variable "instance_name" {
  description = "Redis instance name"
  type        = string
  default     = "oam-redis"
}

variable "account_name" {
  description = "Redis instance user account name"
  type        = string
  default     = "oam"
}

variable "password" {
  description = "RDS instance account password"
  type        = string
  default     = "Xyfff83jfewGGfaked"
}

