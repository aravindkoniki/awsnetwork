# VPC
variable "vpc_name" {
  description = "Desired name for the VPC resources."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden."
  type        = string
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool."
  type        = list(string)
  default     = []
}

variable "create_igw" {
  description = "Create Internet gateway"
  type        = bool
  default     = false
}

variable "igw_name" {
  description = "Internet gateway name"
  type        = string
  default     = ""
}

variable "nat_gateways" {
  description = "NAT Gateway configuration"
  default     = null
}


# subnets
variable "subnets" {
  description = "A map of subnet with parameters to create subnets in DMZ with NACL and Route tables, jSON  in a specifed format in the example"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}