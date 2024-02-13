data "aws_region" "current" {}

locals {
  is_creation_allowed      = (var.is_security_group_creation_allowed == true && var.add_rules_to_existing_security_group == false) ? true : false
  nsg_ingress_rules        = (var.is_security_group_creation_allowed == true || var.add_rules_to_existing_security_group == true) ? var.nsg_ingress_rules : []
  nsg_egress_rules         = (var.is_security_group_creation_allowed == true || var.add_rules_to_existing_security_group == true) ? var.nsg_egress_rules : []
  nsg_ingress_egress_rules = concat(local.nsg_ingress_rules, local.nsg_egress_rules)
  security_group_id        = (var.is_security_group_creation_allowed == true && var.add_rules_to_existing_security_group == false) ? aws_security_group.sg[0].id : var.existing_security_group_id
}


resource "aws_security_group" "sg" {
  count                  = var.is_security_group_creation_allowed == true && var.add_rules_to_existing_security_group == false ? 1 : 0
  name                   = upper(var.security_group_name)
  description            = var.security_group_description
  vpc_id                 = var.vpc_id
  tags                   = merge({ "Name" = upper(var.security_group_name), "ManagedBy" = "Terraform" }, var.tags)
  revoke_rules_on_delete = var.revoke_rules_on_delete
}

resource "aws_security_group_rule" "nsg_rules" {
  count             = length(local.nsg_ingress_egress_rules)
  security_group_id = local.security_group_id

  type        = lookup(local.nsg_ingress_egress_rules[count.index], "type", null)
  from_port   = lookup(local.nsg_ingress_egress_rules[count.index], "from_port", null)
  to_port     = lookup(local.nsg_ingress_egress_rules[count.index], "to_port", null)
  protocol    = lookup(local.nsg_ingress_egress_rules[count.index], "protocol", null)
  description = lookup(local.nsg_ingress_egress_rules[count.index], "description", "Managed by Terraform")


  cidr_blocks              = lookup(local.nsg_ingress_egress_rules[count.index], "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(local.nsg_ingress_egress_rules[count.index], "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(local.nsg_ingress_egress_rules[count.index], "prefix_list_ids", null)
  self                     = lookup(local.nsg_ingress_egress_rules[count.index], "self", null)
  source_security_group_id = lookup(local.nsg_ingress_egress_rules[count.index], "source_security_group_id", null)

  depends_on = [
    aws_security_group.sg
  ]
}