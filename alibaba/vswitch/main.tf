resource "alicloud_vpc" "vpc" {
  count       = var.vpc_id != "" ? 0 : var.create_vpc ? 1 : 0
  vpc_name    = var.vpc_name
  cidr_block  = var.vpc_cidr
  description = var.vpc_description
}

resource "alicloud_vswitch" "vswitches" {
  vpc_id       = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  vswitch_name = var.vswitch_name
  cidr_block   = var.vswitch_cidr
  description  = var.vswitch_description
  zone_id      = var.zone_id
}

# VPC variables
variable "create_vpc" {
  description = "Whether to create vpc. If false, you can specify an existing vpc by setting 'vpc_id'."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "terraform"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc."
  type        = string
  default     = "A new VPC created by Terraform"
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
  default     = "172.16.0.0/12"
}

# Vsiwtch variables
variable "vpc_id" {
  description = "The vpc id used to launch several vswitches. If set, the 'create' will be ignored."
  type        = string
  default     = ""
}

variable "vswitch_cidr" {
  description = "cidr blocks used to launch a new vswitch."
  type        = string
  default     = "172.16.0.0/18"
}

# VSwitch variables

variable "vswitch_description" {
  description = "The vswitch description used to launch several new vswitch."
  type        = string
  default     = "New VSwitch created by Terraform"
}

variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-beijing-a"
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitches."
  default     = "terraform"
}