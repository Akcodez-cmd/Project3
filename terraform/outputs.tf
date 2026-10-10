
output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "ec2_instance_id" {
  description = "ID of the web EC2 instance"
  value       = module.compute.instance_id
}

output "ec2_public_ip" {
  description = "Public IP of the web EC2 instance"
  value       = module.compute.instance_public_ip
}
