terraform {
  required_version = ">= 1.0.0"

  required_providers {
    ec = {
      source  = "elastic/ec"
      version = "0.4.0"
    }
  }
}

provider "ec" {
}

data "ec_stack" "latest" {
  version_regex = "latest"
  region        = var.region
}

resource "ec_deployment" "custom-deployment-id" {
  name                   = var.name

  region                 = var.region
  version                = data.ec_stack.latest.version
  deployment_template_id = var.deployment_template_id

  elasticsearch {}
}

# output
output "ES_VERSION" {
  value = ec_deployment.custom-deployment-id.version
}

output "ES_CLOUD_ID" {
  value = ec_deployment.custom-deployment-id.elasticsearch[0].cloud_id
}

output "ES_HTTPS_ENDPOINT" {
  value = ec_deployment.custom-deployment-id.elasticsearch[0].https_endpoint
}

output "ES_USERNAME" {
  value = ec_deployment.custom-deployment-id.elasticsearch_username
}

output "ES_PASSWORD" {
  value     = ec_deployment.custom-deployment-id.elasticsearch_password
  sensitive = true
}

# variable
variable "region" {
  description = "Elasticsearch Service region, full list: https://www.elastic.co/guide/en/cloud/current/ec-regions-templates-instances.html"
  type        = string
  default     = "aws-ap-east-1"
}

variable "deployment_template_id" {
  description = "Deployment template identifier to create the deployment from, full list: https://www.elastic.co/guide/en/cloud/current/ec-regions-templates-instances.html"
  type        = string
  default     = "aws-compute-optimized-v3"
}

variable "name" {
  description = "Name of the deployment"
  type        = string
  default     = "example_deployment"
}
