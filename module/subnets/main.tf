locals {
  subnets = [
    for subnet in aws_subnet.subnets : {
      id   = subnet.id
      arn  = subnet.arn
      name = subnet.tags["Name"]

      availability_zone    = subnet.availability_zone
      availability_zone_id = subnet.availability_zone_id

      cidr_block      = subnet.cidr_block
      ipv6_cidr_block = subnet.ipv6_cidr_block
    }
  ]

  availability_zones = distinct(
    values(aws_subnet.subnets)[*].availability_zone
  )
  availability_zone_ids = distinct(
    values(aws_subnet.subnets)[*].availability_zone_id
  )
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id               = var.vpc_id
  availability_zone    = lookup(each.value, "availability_zone", null)
  availability_zone_id = lookup(each.value, "availability_zone_id", null)

  cidr_block      = lookup(each.value, "cidr_block", "")
  ipv6_cidr_block = lookup(each.value, "ipv6_cidr_block", null)

  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  outpost_arn                     = var.outpost_arn
  customer_owned_ipv4_pool        = var.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch

  tags = merge({ "Name" = upper(lookup(each.value, "name", each.key)), "ManagedBy" = "Terraform" }, lookup(each.value, "tags", {}) , var.tags)

}
