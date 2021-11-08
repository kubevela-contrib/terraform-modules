resource "alicloud_log_project" "project" {
  name        = var.name
  description = var.description
}

variable "name" {
  description = "Name of security group. It is used to create a new security group."
  type        = string
  default     = "terraform-1108"
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}
