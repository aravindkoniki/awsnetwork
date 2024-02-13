data "aws_caller_identity" "current" {}

locals {
  route_table_id_subnet_key = { for p in keys(var.subnets) : p => module.route_table[p].id }
  nacl_id_subnet_key        = { for p in keys(var.subnets) : p => module.nacl[p].id }
  is_nat_deployed           = var.nat_gateways != null ? true : false
  is_igw_deployed           = var.create_igw
  nat_gateway               = var.nat_gateways != null ? { for p in keys(var.nat_gateways) : p => module.nat_gateway[p].id } : null
  igw_id                    = local.is_igw_deployed ? module.igw[0].id : null
}

# vpc module
module "vpc" {
  source                = "../../modules/vpc"
  vpc_name              = var.vpc_name
  cidr_block            = var.cidr_block
  secondary_cidr_blocks = var.secondary_cidr_blocks
  dns_hostnames_enabled = true
  tags                  = var.tags
}

#module internet gateway
module "igw" {
  count    = local.is_igw_deployed ? 1 : 0
  source   = "../../modules/igw"
  igw_name = var.igw_name
  vpc_id   = module.vpc.id
  tags     = merge({ "Name" = "${var.igw_name}" }, var.tags)
  depends_on = [
    module.vpc
  ]
}

# nat gateway module
module "nat_gateway" {
  for_each             = var.nat_gateways != null ? var.nat_gateways : {}
  source               = "../../modules/ngw"
  nat_gateway_name     = var.nat_gateways["${each.key}"].name
  is_private           = lookup(var.nat_gateways["${each.key}"], "is_private", false)
  subnet_id            = lookup(var.nat_gateways["${each.key}"], "subnet_id", module.subnets.subnets_by_name[upper(var.nat_gateways["${each.key}"].subnet_name)].id)
  assign_eip_on_create = lookup(var.nat_gateways["${each.key}"], "assign_eip_on_create", false)
  eip_name             = lookup(var.nat_gateways["${each.key}"], "eip_name", "")
  eip_id               = lookup(var.nat_gateways["${each.key}"], "eip_id", "")
  tags                 = var.tags
  depends_on = [
    module.vpc
  ]
}


# subnets module
module "subnets" {
  source  = "../../modules/subnets"
  vpc_id  = module.vpc.id
  subnets = var.subnets
  tags    = var.tags
  depends_on = [
    module.vpc
  ]
}

# nacl module
module "nacl" {
  for_each      = var.subnets
  source        = "../../modules/nacl"
  nacl_name     = var.subnets["${each.key}"]["nacl"].name
  vpc_id        = module.vpc.id
  subnets       = [lookup(var.subnets["${each.key}"], "subnet_id", module.subnets.subnets_by_name[upper(var.subnets["${each.key}"].name)].id)]
  ingress_rules = var.subnets["${each.key}"]["nacl"].nacl_ingress_rules
  egress_rules  = var.subnets["${each.key}"]["nacl"].nacl_egress_rules
  tags          = merge(var.subnets["${each.key}"]["nacl"]["tags"], var.tags)
  depends_on = [
    module.vpc,
    module.subnets
  ]
}


# route table module
module "route_table" {
  for_each         = var.subnets
  source           = "../../modules/routetables"
  route_table_name = var.subnets["${each.key}"]["route_table"].name
  vpc_id           = module.vpc.id
  subnets          = [lookup(var.subnets["${each.key}"], "subnet_id", module.subnets.subnets_by_name[upper(var.subnets["${each.key}"].name)].id)]
  ipv4_routes = concat(
    var.create_igw == true && lookup(var.subnets["${each.key}"]["route_table"], "add_igw_routes", false) == true ? [
      {
        cidr_block = "0.0.0.0/0",
        gateway_id = "${module.igw[0].id}"
    }] : [],
    var.subnets["${each.key}"]["route_table"].ipv4_routes
  )
  gateways                 = lookup(var.subnets["${each.key}"]["route_table"], "gateways", [])
  vpc_gateway_endpoints    = lookup(var.subnets["${each.key}"]["route_table"], "vpc_gateway_endpoints", [])
  propagating_vpn_gateways = lookup(var.subnets["${each.key}"]["route_table"], "propagating_vpn_gateways", [])
  tags                     = merge(var.subnets["${each.key}"]["route_table"]["tags"], var.tags)
  depends_on = [
    module.vpc,
    module.subnets,
    module.nat_gateway,
    module.igw
  ]
}

