resource "alicloud_slb_load_balancer" "slb" {
  load_balancer_name = var.slb_name
  address_type       = var.address_type
  load_balancer_spec = "slb.s2.small"
  vswitch_id         = var.vswitch_id
}


variable "slb_name" {
  description = "The name of the slb"
  default = "dev"
  type = string
}

variable "vswitch_id" {
  description = "The vswitch id"
  type = string
}

variable "address_type" {
  description = "The address type"
  default = "intranet"
}

output "slb_id" {
  value = alicloud_slb_load_balancer.slb.id
}

output "ip" {
  value = alicloud_slb_load_balancer.slb.address
}
