resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type = var.is_private ? "private" : "public"
  subnet_id         = var.subnet_id
  allocation_id     = length(aws_eip.eip) > 0 ? aws_eip.eip[0].id : var.eip_id

  tags = merge({ "Name" = upper(var.nat_gateway_name), "ManagedBy" = "Terraform" }, var.tags)

}

resource "aws_eip" "eip" {
  count = !var.is_private && var.assign_eip_on_create ? 1 : 0

  tags = merge({ "Name" = upper(var.eip_name), "LinkedResource" = upper(var.nat_gateway_name), "ManagedBy" = "Terraform" }, var.tags)

}
