output "aws_account_id" {
  description = "The AWS Account ID number of the account that owns or contains the calling entity."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_caller_arn" {
  description = "The AWS ARN associated with the calling entity."
  value       = data.aws_caller_identity.current.arn
}

output "aws_caller_user_id" {
  description = "The unique identifier of the calling entity."
  value       = data.aws_caller_identity.current.user_id
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.id
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = module.vpc.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.vpc.cidr_block
}

output "subnet_arns" {
  description = "A list of ARNs of subnets"
  value       = module.subnets.arns
}

output "subnets_by_name" {
  description = "A map of subnets of the subnet group which are grouped by name."
  value       = module.subnets.subnets_by_name
}
