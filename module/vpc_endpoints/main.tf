data "aws_vpc_endpoint_service" "endpoint_service" {
  for_each = { for k, v in var.endpoints : k => v if try(v.create, true) }

  service      = lookup(each.value, "service", null)
  service_name = lookup(each.value, "service_name", null)

  filter {
    name   = "service-type"
    values = [lookup(each.value, "service_type", "Interface")]
  }
}

resource "aws_vpc_endpoint" "endpoint" {
  for_each = { for k, v in var.endpoints : k => v if try(v.create, true) }

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.endpoint_service[each.key].service_name
  vpc_endpoint_type = lookup(each.value, "service_type", "Interface")
  auto_accept       = lookup(each.value, "auto_accept", null)

  security_group_ids  = lookup(each.value, "service_type", "Interface") == "Interface" ? distinct(concat(var.security_group_ids, lookup(each.value, "security_group_ids", []))) : null
  subnet_ids          = lookup(each.value, "service_type", "Interface") == "Interface" || lookup(each.value, "service_type", "Interface") == "GatewayLoadBalancer" ? distinct(concat(var.subnet_ids, lookup(each.value, "subnet_ids", []))) : null
  route_table_ids     = lookup(each.value, "service_type", "Interface") == "Gateway" ? lookup(each.value, "route_table_ids", null) : null
  policy              = lookup(each.value, "policy", null)
  private_dns_enabled = lookup(each.value, "service_type", "Interface") == "Interface" ? lookup(each.value, "private_dns_enabled", null) : null

  tags = merge(lookup(each.value, "tags", {}), { "ManagedBy" = "Terraform"}, var.tags)
 
}
