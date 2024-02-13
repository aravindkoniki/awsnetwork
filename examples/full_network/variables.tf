variable "region" {
  type        = string
  description = "Region for the resource to deploy"
}

variable "vpc_name" {
  description = "Desired name for the VPC resources."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden."
  type        = string
}

variable "dns_hostnames_enabled" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = false
}


variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A map of subnet with parameters to create subnets with NACL and Route tables"
}

variable "security_group" {
  description = "security group on vpc"
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}