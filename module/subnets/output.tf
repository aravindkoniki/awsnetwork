output "vpc_id" {
  description = "The ID of the VPC which the subnet group belongs to."
  value       = var.vpc_id
}

output "ids" {
  description = "A list of IDs of subnets"
  value       = values(aws_subnet.subnets)[*].id
}

output "arns" {
  description = "A list of ARNs of subnets"
  value       = values(aws_subnet.subnets)[*].arn
}

output "cidr_blocks" {
  description = "The CIDR blocks of the subnet group."
  value       = values(aws_subnet.subnets)[*].cidr_block
}

output "ipv6_cidr_blocks" {
  description = "The IPv6 CIDR blocks of the subnet group."
  value       = compact(values(aws_subnet.subnets)[*].ipv6_cidr_block)
}

output "availability_zones" {
  description = "A list of availability zones which the subnet group uses."
  value       = local.availability_zones
}

output "availability_zone_ids" {
  description = "A list of availability zone IDs which the subnet group uses."
  value       = local.availability_zone_ids
}

output "subnets" {
  description = "A list of subnets of the subnet group."
  value       = local.subnets
}

output "subnets_by_az" {
  description = "A map of subnets of the subnet group which are grouped by availability zone id."
  value = {
    for subnet in local.subnets :
    subnet.availability_zone_id => subnet...
  }
}

output "subnets_by_name" {
  description = "A map of subnets of the subnet group which are grouped by name."
  value = {
    for subnet in local.subnets :
    subnet.name => {
      id                   = subnet.id
      arn                  = subnet.arn
      name                 = subnet.name
      availability_zone    = subnet.availability_zone
      availability_zone_id = subnet.availability_zone_id
      cidr_block           = subnet.cidr_block
      ipv6_cidr_block      = subnet.ipv6_cidr_block
    }
  }
}

output "tags" {
  description = "A map of tags assigned to the resource"
  value       = { for subnet in aws_subnet.subnets : subnet.tags["Name"] => subnet.tags }
}