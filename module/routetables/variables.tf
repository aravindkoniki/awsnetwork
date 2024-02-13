variable "route_table_name" {
  description = "Desired name for the route table resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC which the route table belongs to."
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the route table."
  type        = list(string)
  default     = []
}

variable "gateways" {
  description = "A list of gateway IDs to associate with the route table. Currently it only supports Internet Gateway and Virtual Private Gateway."
  type        = list(string)
  default     = []
}

variable "vpc_gateway_endpoints" {
  description = "A list of the VPC Endpoint IDs with which the Route Table will be associated."
  type        = list(string)
  default     = []
}

variable "propagating_vpn_gateways" {
  description = "A list of Virtual Private Gateway IDs to propagate routes from."
  type        = list(string)
  default     = []
}

variable "is_main" {
  description = "Whether to set this route table as the main route table."
  type        = bool
  default     = false
}

variable "ipv4_routes" {
  description = "A list of route rules for IPv4 CIDRs."
  type        = list(map(string))
  default     = []
}

variable "ipv6_routes" {
  description = "A list of route rules for IPv6 CIDRs."
  type        = list(map(string))
  default     = []
}

variable "prefix_list_routes" {
  description = "A list of route rules for Managed Prefix List."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}