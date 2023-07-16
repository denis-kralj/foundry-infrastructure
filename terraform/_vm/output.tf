# outputs that terraform spits out after completion
output "instance_ip" {
  description = "public IP assigned"
  value       = aws_instance.foundry-server.public_ip
}

output "instance_id" {
  description = "ARN for created instance"
  value = aws_instance.foundry-server.id
}