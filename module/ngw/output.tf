output "id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.nat_gateway.id
}

output "subnet_id" {
  description = "NAT Gateway associated subnet id"
  value       = aws_nat_gateway.nat_gateway.subnet_id
}

output "connectivity_type" {
  description = "Connectivity type for the gateway. Valid values are private and public."
  value       = aws_nat_gateway.nat_gateway.connectivity_type
}

output "eip_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway."
  value       = aws_nat_gateway.nat_gateway.allocation_id
}

output "eni_id" {
  description = "The ENI ID of the network interface created by the NAT gateway."
  value       = aws_nat_gateway.nat_gateway.network_interface_id
}

output "public_ip" {
  description = "The public IP address of the NAT Gateway."
  value       = aws_nat_gateway.nat_gateway.public_ip
}

output "private_ip" {
  description = "The private IP address of the NAT Gateway."
  value       = aws_nat_gateway.nat_gateway.private_ip
}

output "tags" {
  description = "A map of tags assigned to the resource"
  value       = aws_nat_gateway.nat_gateway.tags
}