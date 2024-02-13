output "name" {
  description = "The VPC name."
  value       = var.vpc_name
}

output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}

output "cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.vpc.cidr_block
}

output "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC."
  value       = var.secondary_cidr_blocks
}

output "ipv6_cidr_block" {
  description = "The IPv6 CIDR block."
  value       = aws_vpc.vpc.ipv6_cidr_block
}

output "ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_vpc.vpc.ipv6_association_id
}

output "instance_tenancy" {
  description = "Tenancy of instances spin up within VPC."
  value       = aws_vpc.vpc.instance_tenancy
}

output "dns_support_enabled" {
  description = "Whether or not the VPC has DNS support."
  value       = aws_vpc.vpc.enable_dns_support
}

output "dns_hostnames_enabled" {
  description = "Whether or not the VPC has DNS hostname support."
  value       = aws_vpc.vpc.enable_dns_hostnames
}

output "dns_dnssec_validation_id" {
  description = "The ID of a configuration for DNSSEC validation."
  value       = try(aws_route53_resolver_dnssec_config.route53_resolver.*.id[0], null)
}

output "private_hosted_zones" {
  description = "List of associated private Hosted Zone IDs."
  value       = values(aws_route53_zone_association.route53_zone)[*].zone_id
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation."
  value       = aws_vpc.vpc.default_security_group_id
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL."
  value       = aws_vpc.vpc.default_network_acl_id
}

output "default_route_table_id" {
  description = "The ID of the default route table."
  value       = aws_vpc.vpc.default_route_table_id
}

output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table."
  value       = aws_vpc.vpc.main_route_table_id
}

output "dhcp_options_id" {
  description = "The ID of the DHCP Options Set."
  value       = try(aws_vpc_dhcp_options.vpc_dhcp_options.*.id[0], null)
}

output "dhcp_options_arn" {
  description = "The ARN of the DHCP Options Set."
  value       = try(aws_vpc_dhcp_options.vpc_dhcp_options.*.arn[0], null)
}

output "tags" {
  description = "A map of tags assigned to the resource"
  value       = aws_vpc.vpc.tags
}