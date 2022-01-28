locals {
  vpc_id = try(var.vpc_id, aws_vpc.this[0].id, "")

}

resource "aws_vpc" "this" {
  count = var.create_vpc && var.vpc_id == "" ? 1 : 0

  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
  { "Name" = var.name },
  var.vpc_tags,
  )
}

data "aws_availability_zones" "default" {
  state = "available"
}

resource "aws_subnet" "default" {
  vpc_id                          = local.vpc_id
  cidr_block                      = var.subnet_cidr
  availability_zone               = var.availability_zone==""? data.aws_availability_zones.default.names[0] : var.availability_zone
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  ipv6_cidr_block = var.assign_ipv6_address_on_creation ? var.ipv6_cidr_block : null
  tags = merge(var.subnet_tags,
  )
}


output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.default.id
}

output "subnet_arns" {
  description = "Subnet ARNs"
  value       = aws_subnet.default.arn
}

output "subnets_ipv6_cidr_blocks" {
  description = "Subnet IPv6 CIDR Blocks"
  value       = aws_subnet.default.ipv6_cidr_block
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       =local.vpc_id
}