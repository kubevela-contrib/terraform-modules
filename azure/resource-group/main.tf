provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.name
  location = var.location
}

variable "name" {
  default = "example"
  description = "The name of the resource group"
  type = string
}

variable "location" {
  default = "East US"
  description = "The location of the resource group"
  type = string
}

output "resource_group_name" {
  value = var.name
  description = "The name of the resource group"
}