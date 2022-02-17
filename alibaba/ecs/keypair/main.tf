resource "alicloud_ecs_key_pair" "example" {
  key_pair_name = "key_pair_name"
}

output "xxx" {
  value = alicloud_ecs_key_pair.example
}