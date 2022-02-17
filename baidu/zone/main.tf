terraform {
  required_providers {
    baiducloud = {
      source = "baidubce/baiducloud"
      version = "1.12.0"
    }
  }
}

data "baiducloud_zones" "default" {
}

output "zone_name" {
  value = data.baiducloud_zones.default
}