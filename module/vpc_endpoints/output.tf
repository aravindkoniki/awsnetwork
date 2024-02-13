output "ids" {
  description = "Endpoint ARN for all the resources created"
  value       = { for p in sort(keys(var.endpoints)) : p => aws_vpc_endpoint.endpoint[p].id }
}

output "arns" {
  description = "Endpoint ARN for all the resources created"
  value       = { for p in sort(keys(var.endpoints)) : p => aws_vpc_endpoint.endpoint[p].arn }
}

output "endpoints" {
  description = "Array containing the full resource object and attributes for all endpoints created"
  value       = aws_vpc_endpoint.endpoint
}

