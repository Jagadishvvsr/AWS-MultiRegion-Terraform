data "aws_availability_zones" "availability_zones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  use_public_custom = length(var.public_subnets) > 0
}


locals {
  use_private_custom = length(var.private_subnets) > 0
}


locals {
    public_subnet_final = local.use_public_custom ? [
    
   for i, subnet in var.public_subnets : {
     cidr = subnet.cidr != null ? subnet.cidr :
     cidrsubnet(aws_vpc.Custom_vpc.cidr_block, 8 , i)
   
   az = subnet.az != null ? subnet.az :
       data.aws_availability_zones.availability_zones.names[ i % length(data.aws_availability_zones.availability_zones.names)]
    }
    ] : [
    
    for i in range(var.public_subnet_count) : {
      cidr = cidrsubnet(aws_vpc.Custom_vpc.cidr_block, 8 , i)

      az = data.aws_availability_zones.availability_zones.names[ i % lenth(data.aws_availability_zones.availability_zones.names)]
    }

    ]

}

locals {

 private_subnet_final = local.use_private_custom ? [
    for i , subnet in var.private_subnets : {
     cidr = subnet.cidr != null ? : subnet.cidr : cidrsubnet(aws_vpc.Custom_vpc.cidr_block, 8, i)}

    az = subnet.az != null ? subnet.az : data.aws_availability_zones.availability_zones.names[ i % length(data.aws_availability_zones.availability_zones.names)]
    }
 
 ] : [

  for i in range(var.private_subnet_count) : {
    cidr = cidrsubnet(aws_vpc.Custom_vpc.cidr_block , 8 , i )

    az = data.aws_availability_zones.availability_zones.names[i % length(data.aws_availability_zones.availability_zones.names)]
  
  }
  ]

}


resource "aws_vpc" "Custom_vpc" {
  cidr_block = var.Vpc_Cidr_Block
  #region = var.region
  instance_tenancy = var.instance_tenancy    
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames 
  

}


resource "aws_subnet" "public_subnet" {
  for_each = {
  for i, subnet in local.public_subnet_final:
  i =>  subnet
  }
  vpc_id     = aws_vpc.Custom_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  #region = var.Vpc_region

  tags = {
    Name = "Public-${each.key}-Env
  }
}


resource "aws_subnet" "private_subnet"{
 for_each = {
   for i, subnet in local.private_subnet_final:
   i => subnet
 }
  vpc_id     = aws_vpc.Custom_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  #region = var.Vpc_region

  tags = {
    Name = "Public-${each.key}-Env
  }

}

resource "aws_eip" "nat-eip" {
 for_each = aws_subnet.public_subnet
 #region = var.Vpc_region
 domain = vpc

}


resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.Custom_vpc.id

  tags = {
    Name = "internet_gw_${aws_vpc.Custom_vpc.id}"
  }
}


resource "aws_nat_gateway" "public_NAT_gateway" {
 for_each = aws_subnet.public_subnet

  allocation_id = aws_eip.nat-eip[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "gw NAT-${each.key}-Env"
  }
   depends_on = [aws_internet_gateway.internetgw]
}


resource "aws_route_table" "public_routetable" {

  vpc_id = aws_vpc.Custom_vpc.id

  route = []

  tags = {
    Name = "Public-${aws_vpc.Custom_vpc.id}_routetable"
  }
}



resource "aws_route_table" "private_routetable" {
 for_each = aws_subnet.private_subnet

  vpc_id = aws_vpc.Custom_vpc.id

  route = []

  tags = {
    Name = "Private-${aws_vpc.Custom_vpc.id}_routetable"
  }
}


resource "aws_route" "route_public" {
  route_table_id            = aws_route_table.public_routetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internetgw.id
}

resource "aws_route_table_association" "pubsubnet_assoc" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_routetable.id
}


resource "aws_route" "route_private" {
  for_each = aws_subnet.private_subnet
  
  route_table_id            = aws_route_table.private_routetable.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.public_NAT_gateway.id

}

source "aws_route_table_association" "privatesubnet_assoc" {
  for_each = aws_subnet.private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_routetable.id
}
