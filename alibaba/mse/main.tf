module "vswitch" {
  source = "git::github.com/kubevela-contrib/terraform-modules.git//alibaba/vswitch"
}

resource "alicloud_mse_cluster" "prod" {
  cluster_specification = var.cluster_specification
  instance_count        = 1
  cluster_type          = var.cluster_type
  cluster_version       = var.cluster_version
  net_type              = var.net_type
  vswitch_id            = module.vswitch.VSWITCH_ID
  pub_network_flow      = "1"
  acl_entry_list        = var.acl_entry_list
  cluster_alias_name    = var.cluster_alias_name
}

data "alicloud_mse_clusters" "prod" {
  ids    = [resource.alicloud_mse_cluster.prod.id]
  status = "INIT_SUCCESS"
}

variable "cluster_specification" {
  description = "The engine specification of MSE Cluster. Valid values: MSE_SC_1_2_200_c：1C2G MSE_SC_2_4_200_c：2C4G MSE_SC_4_8_200_c：4C8G MSE_SC_8_16_200_c：8C16G"
  type        = string
  default     = "MSE_SC_1_2_200_c"
}

variable "cluster_type" {
  description = "The type of MSE Cluster. Valid values: ZooKeeper、Nacos-Ans and Eureka"
  type        = string
  default     = "Nacos-Ans"
}

variable "cluster_version" {
  description = "The version of MSE Cluster. Valid values: ZooKeeper_3_4_14, ZooKeeper_3_5_5, NACOS_ANS_1_1_3, NACOS_ANS_1_2_1, EUREKA_1_9_3"
  type        = string
  default     = "NACOS_ANS_1_2_1"
}

variable "net_type" {
  description = "The type of network. Valid values: privatenet and pubnet"
  type        = string
  default     = "pubnet"
}

variable "acl_entry_list" {
  description = "The whitelist"
  type        = list(any)
  default     = ["127.0.0.1/32"]
}

variable "cluster_alias_name" {
  description = "The alias name of MSE Cluster"
  type        = string
  default     = "tf-testAccMseCluster"
}

output "RESOURCE_IDENTIFIER" {
  description = "The identifier of the resource"
  value       = data.alicloud_mse_clusters.prod.clusters.0.id
}

output "INTERNET_DOMAIN" {
  description = "The internet domain of the resource"
  value       = data.alicloud_mse_clusters.prod.clusters.0.internet_domain
}

output "INTERNET_PORT" {
  description = "The internet port of the resource"
  value       = 8848
}

output "INTRANET_DOMAIN" {
  description = "The intranet domain of the resource"
  value       = data.alicloud_mse_clusters.prod.clusters.0.intranet_domain
}

output "INTRANET_PORT" {
  description = "The intranet port of the resource"
  value       = 8848
}

output "Net_TYPE" {
  value = var.net_type
  description = "The type of network"
}
