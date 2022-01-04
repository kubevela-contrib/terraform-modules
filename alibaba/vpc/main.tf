resource "alicloud_vpc" "vpc" {
  vpc_name    = var.vpc_name
  cidr_block  = var.vpc_cidr
  description = var.vpc_description
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "TF-VPC"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc."
  type        = string
  default     = "A new VPC created by Terrafrom"
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
  default     = "172.16.0.0/12"
}

output "VPC_ID" {
  description = "The vpc id of the newly created vpc."
  value = resource.alicloud_vpc.vpc.id
}
