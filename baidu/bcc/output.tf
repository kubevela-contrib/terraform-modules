output "public_ip" {
  value = baiducloud_instance.default.0.public_ip
}

output "internal_ip" {
  value = baiducloud_instance.default.0.internal_ip
}

output "id" {
  value = baiducloud_instance.default.0.id
}

output "password" {
  value = var.admin_pass
}