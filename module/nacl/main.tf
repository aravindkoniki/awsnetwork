resource "aws_network_acl" "nacl" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  tags = merge({ "Name" = upper(var.nacl_name), "ManagedBy" = "Terraform" }, var.tags)
}

resource "aws_network_acl_rule" "ingress" {
  count = length(var.ingress_rules)

  network_acl_id = aws_network_acl.nacl.id

  egress          = false
  rule_number     = lookup(var.ingress_rules[count.index], "rule_number", "")
  rule_action     = lookup(var.ingress_rules[count.index], "rule_action", "")
  protocol        = lookup(var.ingress_rules[count.index], "protocol", -1)
  from_port       = lookup(var.ingress_rules[count.index], "from_port", null)
  to_port         = lookup(var.ingress_rules[count.index], "to_port", null)
  icmp_type       = lookup(var.ingress_rules[count.index], "icmp_type", null)
  icmp_code       = lookup(var.ingress_rules[count.index], "icmp_code", null)
  cidr_block      = lookup(var.ingress_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.ingress_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "egress" {
  count = length(var.egress_rules)

  network_acl_id = aws_network_acl.nacl.id

  egress          = true
  rule_number     = lookup(var.egress_rules[count.index], "rule_number", "")
  rule_action     = lookup(var.egress_rules[count.index], "rule_action", "")
  protocol        = lookup(var.egress_rules[count.index], "protocol", -1)
  from_port       = lookup(var.egress_rules[count.index], "from_port", null)
  to_port         = lookup(var.egress_rules[count.index], "to_port", null)
  icmp_type       = lookup(var.egress_rules[count.index], "icmp_type", null)
  icmp_code       = lookup(var.egress_rules[count.index], "icmp_code", null)
  cidr_block      = lookup(var.egress_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.egress_rules[count.index], "ipv6_cidr_block", null)
}
