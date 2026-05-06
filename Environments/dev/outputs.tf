output "vpc_id" {
  value = module.Custom_vpc.vpc_id
    
}

output "elastic_ip" {
  value = module.Custom_vpc.elastic_ip
} 

output "public_subnet_ids" {
  value = module.Custom_vpc.public_subnets_ids
}

output "private_subnet_ids" {
  value = module.Custom_vpc.private_subnets_ids
}

output "public_subnet_names" {
  value = module.Custom_vpc.public_subnet_names
}

output "private_subnet_names" {
  value = module.Custom_vpc.private_subnet_names
}

/* output "debug_public_final" {
  value = local.public_subnet_final
}

output "debug_private_final" {
  value = local.private_subnet_final
}  */

output "azs" {
  value = data.aws_availability_zones.availability_zones.names
}