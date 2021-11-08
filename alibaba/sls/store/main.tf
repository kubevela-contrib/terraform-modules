resource "alicloud_log_project" "project" {
  count       = var.create_project ? 1 : 0
  name        = var.project_name
  description = var.description
}

resource "alicloud_log_store" "store" {
  name                  = var.store_name
  project               = var.project_name
  shard_count           = var.store_shard_count
  auto_split            = var.store_auto_split
  max_split_shard_count = var.store_max_split_shard_count
  append_meta           = var.store_append_meta
}

# Log project variables
variable "project_name" {
  description = "Name of security group. It is used to create a new security group."
  type        = string
  default     = "terraform-1108"
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

# Log store variables
variable "create_project" {
  description = "Whether to create log resources"
  type        = string
  default     = true
}

variable "store_name" {
  description = "Log store name."
  type        = string
  default     = "terraform-sls-store"
}

variable "store_retention_period" {
  description = "The data retention time (in days). Valid values: [1-3650]. Default to 30. Log store data will be stored permanently when the value is '3650'."
  type        = number
  default     = 30
}

variable "store_shard_count" {
  description = "The number of shards in this log store. Default to 2. You can modify it by 'Split' or 'Merge' operations."
  type        = number
  default     = 2
}

variable "store_auto_split" {
  description = "Determines whether to automatically split a shard. Default to true."
  type        = bool
  default     = true
}

variable "store_max_split_shard_count" {
  description = "The maximum number of shards for automatic split, which is in the range of 1 to 64. You must specify this parameter when autoSplit is true."
  type        = number
  default     = 1
}

variable "store_append_meta" {
  description = "Determines whether to append log meta automatically. The meta includes log receive time and client IP address. Default to true."
  type        = bool
  default     = true
}
