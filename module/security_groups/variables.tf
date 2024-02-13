variable "is_security_group_creation_allowed" {
  description = "Parameter to enable and disable the module conditionally, from the other modules"
  type        = bool
  default     = true
}

variable "add_rules_to_existing_security_group" {
  description = "Parameter to add rules to existing security groups, value 'add_rules_to_existing_security_group=true', 'is_security_group_creation_allowed=false' and set 'default_security_group_id' value"
  type        = bool
  default     = false
}

variable "existing_security_group_id" {
  description = "Default security group id, 'is_security_group_creation_allowed=false', 'add_rules_to_existing_security_group = true'"
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "The name to assign to the security group. Must be unique within the VPC."
  type        = string
}

variable "security_group_description" {
  description = "The description to assign to the created Security Group."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The ID of the VPC where the Security Group will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "revoke_rules_on_delete" {
  description = <<-EOT
    Instruct Terraform to revoke all of the Security Group's attached ingress and egress rules before deleting
    the security group itself. This is normally not needed.
    EOT
  type        = bool
  default     = false
}

variable "nsg_ingress_rules" {
  type        = list(any)
  default     = []
  description = <<-EOT
    A list of Ingress Security Group rule objects. The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` 
    resource.
    EOT
}

variable "nsg_egress_rules" {
  type        = list(any)
  default     = []
  description = <<-EOT
    A list of Egress Security Group rule objects. The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` 
    resource.
    EOT
}