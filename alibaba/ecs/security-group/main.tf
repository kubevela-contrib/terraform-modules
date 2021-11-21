resource "alicloud_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = module.vpc.VPC_ID
}

resource "alicloud_security_group_rule" "sg_rule" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = var.port_range
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = var.cidr_ip
}

module "vpc" {
  source = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/vswitch"
  zone_id = var.zone_id
}

variable "name" {
  default = "tf"
  description = "The name of the security group rule"
  type = string
}

variable "description" {
  default = "The description of the security group rule"
  description = "The description of the security group rule"
  type = string
}

variable "port_range" {
  default = "1/65535"
  description = "The port range of the security group rule"
  type = string
}

variable "cidr_ip" {
  description = "cidr blocks used to create a new security group rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-hongkong-b"
}

output "SECURITY_GROUP_ID" {
  value = alicloud_security_group.sg.id
}

output "VSWITCH_ID" {
  value = module.vpc.VSWITCH_ID
}

output "VPC_ID" {
  value = module.vpc.VPC_ID
}