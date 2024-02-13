
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = merge({ "Name" = upper(var.route_table_name), "ManagedBy" = "Terraform" }, var.tags)

}

resource "aws_main_route_table_association" "main" {
  count = var.is_main ? 1 : 0

  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.route_table.id
}

# Routes
resource "aws_route" "ipv4" {
  for_each = {
    for route in var.ipv4_routes :
    route.cidr_block => route
  }

  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}

resource "aws_route" "ipv6" {
  for_each = {
    for route in var.ipv6_routes :
    route.cidr => route
  }

  route_table_id              = aws_route_table.route_table.id
  destination_ipv6_cidr_block = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}

resource "aws_route" "prefix_list" {
  for_each = {
    for route in var.prefix_list_routes :
    route.id => route
  }

  route_table_id             = aws_route_table.route_table.id
  destination_prefix_list_id = each.key

  carrier_gateway_id        = try(each.value.carrier_gateway_id, null)
  egress_only_gateway_id    = try(each.value.egress_only_gateway_id, null)
  gateway_id                = try(each.value.gateway_id, null)
  local_gateway_id          = try(each.value.local_gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}

# Associations
resource "aws_route_table_association" "subnets" {
  count = length(var.subnets)

  route_table_id = aws_route_table.route_table.id
  subnet_id      = var.subnets[count.index]
}

resource "aws_route_table_association" "gateways" {
  count = length(var.gateways)

  route_table_id = aws_route_table.route_table.id
  gateway_id     = var.gateways[count.index]
}


# VPC Gateway Endpoint Association
resource "aws_vpc_endpoint_route_table_association" "endpoints" {
  count = length(var.vpc_gateway_endpoints)

  route_table_id  = aws_route_table.route_table.id
  vpc_endpoint_id = var.vpc_gateway_endpoints[count.index]
}


# Route Propagations
resource "aws_vpn_gateway_route_propagation" "vpn" {
  count = length(var.propagating_vpn_gateways)

  route_table_id = aws_route_table.route_table.id
  vpn_gateway_id = var.propagating_vpn_gateways[count.index]
}
