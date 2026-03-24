outputs "vpc_id" {
  value = aws_vpc.Custom_vpc.id
    
}

outputs "elastic_ip" {
  
  for_each = aws_eip.nat-eip.id

  value = each.value
 

}