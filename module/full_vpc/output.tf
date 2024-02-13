output "aws_account_id" {
  description = "The AWS Account ID number of the account that owns or contains the calling entity."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_caller_arn" {
  description = "The AWS ARN associated with the calling entity."
  value       = data.aws_caller_identity.current.arn
}

output "aws_caller_user_id" {
  description = "The unique identifier of the calling entity."
  value       = data.aws_caller_identity.current.user_id
}

# vpc 
output "vpc_id" {
  description = "Output of VPC"
  value       = module.vpc.id
}

output "vpc_arn" {
  description = "Output of VPC"
  value       = module.vpc.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.vpc.cidr_block
}

#  Subnets
output "subnet_ids" {
  description = "A list  subnet IDs"
  value       = module.subnets.ids
}

output "subnets_by_name" {
  description = "subnets by name"
  value       = module.subnets.subnets_by_name
}

output "route_table_id_subnet_key" {
  description = "routetable id by subnet key"
  value       = local.route_table_id_subnet_key
}

output "igw_id" {
  description = "internet gateway id"
  value       = local.igw_id
}

output "nat_gateway_key" {
  description = "NAT Gateway id by key"
  value       = var.nat_gateways != null ? local.nat_gateway : null
}

output "nacl_id_subnet_key" {
  description = "routetable id by subnet key"
  value       = local.nacl_id_subnet_key
}

output "tags" {
  description = "A map of tags assigned to the resource"
  value       = var.tags
}
