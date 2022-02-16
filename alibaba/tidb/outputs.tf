#output "this_ecs_id" {
#  value = alicloud_instance.default.id
#}

#output "this_rds_id" {
#  value = alicloud_db_instance.default.id
#}

#output "this_slb_id" {
#  value = alicloud_slb_load_balancer.default.id
#}

#output "this_eip_id" {
#  value = alicloud_eip.default.id
#}

#output "this_ecs_name" {
#  value = alicloud_instance.default.instance_name
#}

output "password" {
  value = var.password
}
#
#output "internet_ip" {
#  value = alicloud_instance.default.public_ip
#}
#
#output "private_ip" {
#  value = alicloud_instance.default.private_ip
#}

output "provisioner_ip" {
  value = alicloud_instance.provisioner.public_ip
}

output "tikv_ip" {
  value = alicloud_instance.tikv.*.public_ip
}

output "monitor_ip" {
  value = alicloud_instance.monitor.public_ip
}