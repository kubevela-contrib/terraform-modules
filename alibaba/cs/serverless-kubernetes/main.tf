variable "name" {
  type        = string
  description = "ASK name"
  default     = "ask-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.1.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
}

resource "alicloud_cs_serverless_kubernetes" "serverless" {
  name_prefix                    = var.name
  vpc_id                         = alicloud_vpc.default.id
  vswitch_ids                    = [alicloud_vswitch.default.id]
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  deletion_protection            = false

  load_balancer_spec      = "slb.s2.small"
  time_zone               = "Asia/Shanghai"
  service_cidr            = "172.21.0.0/20"
  service_discovery_types = ["PrivateZone"]
  # Enable log service, A project named k8s-log-{ClusterID} will be automatically created
  logging_type            = "SLS"

  # addons 
  addons {
    # SLB Ingress
    name = "alb-ingress-controller"
  }
  addons {
    name = "metrics-server"
  }
}


// Output kubernetes resource
output "CLUSTER_ID" {
  description = "ID of the kunernetes cluster."
  value       = alicloud_cs_serverless_kubernetes.serverless.id
}

output "Name" {
  value = alicloud_cs_serverless_kubernetes.serverless.name
}
