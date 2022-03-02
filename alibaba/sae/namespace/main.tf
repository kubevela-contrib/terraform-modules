terraform {
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = "1.156.0"
    }
  }
}

resource "alicloud_sae_namespace" "default" {
  namespace_description = var.namespace_description
  namespace_id          = var.namespace_id
  namespace_name        = var.namespace_name
}

variable "namespace_description" {
  description = "Namespace Description"
  default     = "a namespace"
}

variable "namespace_name" {
  description = "Namespace Name"
  type = string
}

variable "namespace_id" {
  description = "Namespace ID"
  type = string
}

output "namespace_id" {
  value = var.namespace_id
  description = "Namespace ID"
}
