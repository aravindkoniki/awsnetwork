data "aws_region" "current" {}

locals {
  current_region                   = data.aws_region.current.name
  default_dhcp_options_domain_name = local.current_region != "us-east-1" ? "${local.current_region}.compute.internal" : "ec2.internal"
}

# AWS VPC
resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  assign_generated_ipv6_cidr_block = var.ipv6_enabled
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.dns_hostnames_enabled
  enable_dns_support               = var.dns_support_enabled

  tags = merge({ "Name" = upper(var.vpc_name), "ManagedBy" = "Terraform" }, var.tags)

}

resource "aws_vpc_ipv4_cidr_block_association" "vpc_ipv4_cidr_block" {
  for_each = toset(var.secondary_cidr_blocks)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key
}

# Associated Route53 Private Hosted Zones
resource "aws_route53_zone_association" "route53_zone" {
  for_each = toset(var.private_hosted_zones)

  vpc_id  = aws_vpc.vpc.id
  zone_id = each.value
}

# Route53 DNSSEC Validation
resource "aws_route53_resolver_dnssec_config" "route53_resolver" {
  count       = var.dns_dnssec_validation_enabled ? 1 : 0
  resource_id = aws_vpc.vpc.id
}


# DHCP Options
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  count                = var.dhcp_options_enabled ? 1 : 0
  domain_name          = var.dhcp_options_domain_name != "" ? var.dhcp_options_domain_name : local.default_dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge({ "Name" = upper("dhcp-domain-options"), "LinkedResource" = upper(var.vpc_name), "ManagedBy" = "Terraform" }, var.tags)

}

resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  count = var.dhcp_options_enabled ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.vpc_dhcp_options[0].id
}
