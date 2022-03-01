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
  namespace_id          = format("%s:demo", var.region)
  namespace_name        = var.namespace_name
}


variable "region" {
  description = "Region"
  type        = string
}

variable "namespace_description" {
  description = "Namespace Description"
  default     = "default"
}

variable "namespace_name" {
  description = "Namespace Name"
}
