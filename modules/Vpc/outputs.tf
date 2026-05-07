output "vpc_id" {
  value = aws_vpc.Custom_vpc.id
    
}

output "elastic_ip" {
  value =  { 
    for k, v in aws_eip.nat_eip : k => v.public_ip
    } 
}

output "public_subnets_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "private_subnets_ids" {
  value = values(aws_subnet.private_subnet)[*].id 
}

output "public_subnet_names" {
  value = {
    for k, v in aws_subnet.public_subnet : k => v.tags["Name"]
  }
}

output "private_subnet_names" {
  value = {
    for k, v in aws_subnet.private_subnet : k => v.tags["Name"]
  }
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