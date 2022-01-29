data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

data "alicloud_images" "windows" {
  most_recent = true
  name_regex  = "^win2019_1809_x64_dtc_en-us_40G.*"
}

data "alicloud_instance_types" "this" {
  cpu_core_count    = 4
  memory_size       = 8
  availability_zone = var.zone_id
}

module "security_group" {
  source  = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/ecs/security-group"
  zone_id = var.zone_id
}

variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-hongkong-b"
}

resource "alicloud_instance" "ecs" {
  image_id                   = data.alicloud_images.windows.ids.0
  instance_type              = data.alicloud_instance_types.this.instance_types.0.id
  vswitch_id                 = module.security_group.VSWITCH_ID
  security_groups            = [module.security_group.SECURITY_GROUP_ID]
  internet_max_bandwidth_out = 10
  description                = var.description
  internet_charge_type       = var.internet_charge_type
  password                   = var.password
  system_disk_category       = var.system_disk_category
  system_disk_size           = var.system_disk_size
}

variable "name" {
  description = "Instance name"
  type        = string
  default     = "tf"
}

variable "description" {
  description = "Instance description"
  type        = string
  default     = "tf"
}

variable "system_disk_category" {
  description = "System disk category"
  type        = string
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "System disk size"
  type        = string
  default     = "50"
}

variable "internet_charge_type" {
  description = "Internet charge type"
  type        = string
  default     = "PayByTraffic"
}

variable "password" {
  description = "Instance password"
  type        = string
  default     = "Terraform456"
}

output "PUBLIC_IP" {
  value = alicloud_instance.ecs.public_ip
}
