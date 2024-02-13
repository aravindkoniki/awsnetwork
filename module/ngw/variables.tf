variable "nat_gateway_name" {
  description = "Desired name for the NAT Gateway resources."
  type        = string
}

variable "is_private" {
  description = "Whether to create the gateway as private or public connectivity type. Defaults to public(false)."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "The ID of the subnet which the NAT Gateway belongs to."
  type        = string
}

variable "assign_eip_on_create" {
  description = "Assign a new Elastic IP to NAT Gateway on create. Set false if you want to provide existing Elastic IP."
  type        = bool
  default     = false
}

variable "eip_name" {
  description = "Desired name for the EIP resource, when 'assign_eip_on_create' is set to true"
  type        = string
  default     = ""
}

variable "eip_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway. Create a new Elastic IP if not provided."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}