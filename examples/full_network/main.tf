data "aws_caller_identity" "current" {}

# VPC
module "vpc" {
  source                = "../../module/vpc"
  vpc_name              = var.vpc_name
  cidr_block            = var.cidr_block
  secondary_cidr_blocks = var.secondary_cidr_blocks
  tags                  = var.tags
}

# subnets
module "subnets" {
  source  = "../../module/subnets"
  vpc_id  = module.vpc.id
  subnets = var.subnets
  tags    = var.tags
  depends_on = [
    module.vpc
  ]
}

# module nacl
module "nacl" {
  for_each      = var.subnets
  source        = "../../module/nacl"
  nacl_name     = var.subnets["${each.key}"]["nacl"].name
  vpc_id        = module.vpc.id
  subnets       = [module.subnets.subnets_by_name[upper(var.subnets["${each.key}"].name)].id]
  ingress_rules = var.subnets["${each.key}"]["nacl"].nacl_ingress_rules
  egress_rules  = var.subnets["${each.key}"]["nacl"].nacl_egress_rules
  tags          = merge(var.subnets["${each.key}"]["nacl"]["tags"], var.tags)
  depends_on = [
    module.vpc,
    module.subnets
  ]
}

# module route table
module "route_table" {
  for_each         = var.subnets
  source           = "../../module/routetables"
  route_table_name = var.subnets["${each.key}"]["route_table"].name
  vpc_id           = module.vpc.id
  subnets          = [module.subnets.subnets_by_name[upper(var.subnets["${each.key}"].name)].id]
  ipv4_routes      = var.subnets["${each.key}"]["route_table"].ipv4_routes
  gateways         = []
  tags             = merge(var.subnets["${each.key}"]["route_table"]["tags"], var.tags)
  depends_on = [
    module.vpc,
    module.subnets
  ]
}

# module IGW
module "igw" {
  source   = "../../module/igw"
  igw_name = "IGW-01"
  vpc_id   = module.vpc.id
  tags     = var.tags
}

# module NGW
module "ngw" {
  source               = "../../module/ngw"
  nat_gateway_name     = "NGW-01"
  subnet_id            = module.subnets.subnets_by_name["VPC-SUBNET-1A"].id
  assign_eip_on_create = true
  tags                 = var.tags

}

# security group
module "security_group" {
  source                     = "../../module/security_groups"
  security_group_name        = var.security_group["name"]
  security_group_description = var.security_group["description"]
  vpc_id                     = module.vpc.id
  nsg_ingress_rules          = var.security_group["nsg_ingress_rules"]
  nsg_egress_rules           = var.security_group["nsg_egress_rules"]
  tags                       = var.tags
  depends_on = [
    module.vpc
  ]
}