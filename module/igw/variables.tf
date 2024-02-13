variable "igw_name" {
  description = "Desired name for the IGW resource."
  type        = string
}


variable "egress_only_internet_gateway_enabled" {
  description = "Should be true if you want to create a new Egress Only Internet Gateway resource and attach it to the VPC."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = " The VPC ID to create in"
  type        = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}