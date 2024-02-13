# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = upper(var.igw_name), "ManagedBy" = "Terraform" }, var.tags)
}

# Egress Only Internet Gateway (IPv6)
resource "aws_egress_only_internet_gateway" "igwipv6" {
  count  = var.egress_only_internet_gateway_enabled ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge({ "Name" = upper(var.igw_name), "ManagedBy" = "Terraform" }, var.tags)
}
