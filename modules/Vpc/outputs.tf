output "vpc_id" {
  value = aws_vpc.Custom_vpc.id
    
}

output "elastic_ip" {
  value = { 
    for k, v in aws_eip.nat-eip : k => v.id 
    } 
}

output "debug_public_subnets" {
  value = var.public_subnets
}

output "debug_private_subnets" {
  value = var.private_subnets
}

output "debug_public_final" {
  value = local.public_subnet_final
}

output "debug_private_final" {
  value = local.private_subnet_final
}

output "azs" {
  value = data.aws_availability_zones.availability_zones.names
}