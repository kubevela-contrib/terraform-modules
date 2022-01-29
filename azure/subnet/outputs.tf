output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = local.virtual_network_name
}


output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = data.azurerm_virtual_network.default.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = azurerm_subnet.subnet.*.id
}

output "subnet_address_spaces" {
  value = var.subnet_prefixes
}