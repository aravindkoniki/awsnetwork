variable "vpc_id" {
  description = "The ID of the VPC which the subnet group belongs to."
  type        = string
}

variable "subnets" {
  description = "A map of subnet parameters to create subnets for the subnet group."
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch."
  type        = bool
  default     = false
}

variable "assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch."
  type        = bool
  default     = false
}

variable "outpost_arn" {
  description = "The ARN of the Outpost."
  type        = string
  default     = ""
}

variable "customer_owned_ipv4_pool" {
  description = "The customer owned IPv4 address pool. `outpost_arn` argument must be specified when configured."
  type        = string
  default     = ""
}

variable "map_customer_owned_ip_on_launch" {
  description = "Should be true if network interfaces created in the subnet should be assigned a customer owned IP address."
  type        = bool
  default     = false
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}