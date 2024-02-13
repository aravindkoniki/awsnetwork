output "security_group_id" {
  description = "The created or target Security Group ID"
  value       = local.security_group_id
}

output "security_group_arn" {
  description = "The created Security Group ARN, returns value only for the newly created security group"
  value       = local.is_creation_allowed == true ? aws_security_group.sg[0].arn : ""
}

output "tags" {
  description = "Tags created for this resource, return tags for newly created security group"
  value       = local.is_creation_allowed == true ? aws_security_group.sg[0].tags : {}
}