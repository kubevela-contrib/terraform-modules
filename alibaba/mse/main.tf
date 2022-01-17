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
  description = "The engine specification of MSE Cluster"
  type        = string
  default     = "MSE_SC_1_2_200_c"
}

variable "cluster_type" {
  description = "The type of MSE Cluster"
  type        = string
  default     = "Nacos-Ans"
}

variable "cluster_version" {
  description = "The version of MSE Cluster"
  type        = string
  default     = "NACOS_ANS_1_2_1"
}

variable "net_type" {
  description = "The type of network"
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
