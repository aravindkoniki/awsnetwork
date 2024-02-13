output "id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.igw.id
}

output "arn" {
  description = "The ARN of the Internet Gateway."
  value       = aws_internet_gateway.igw.arn
}

output "egress_only_id" {
  description = "The ID of the Egress Only Internet Gateway."
  value       = var.egress_only_internet_gateway_enabled ? aws_egress_only_internet_gateway.igwipv6[0].id : null
}

output "tags_ipv4" {
  description = "A map of tags assigned to the resource IPV4"
  value       = aws_internet_gateway.igw.tags
}

output "tags_ipv6" {
  description = "A map of tags assigned to the resource IPV6"
  value       = var.egress_only_internet_gateway_enabled ? aws_egress_only_internet_gateway.igwipv6[0].tags : {}
}