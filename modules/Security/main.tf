## Aurora Global Data Base security resource and configuration

resource "aws_security_group" "AuroraGDB_SG" {
  name        = "AuroraGDB_SecurityGroup"
  description = "Allow TLS inbound traffic from ASG"
  vpc_id      = module.Vpc.Custom_vpc.id

  tags = {
    Name = "AuroraGDB_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_to_AURORA" {
  security_group_id = aws_security_group.AuroraGDB_SG.id
  security_group = [ aws_security_group.AutoScalingGroup_SG.id]
  from_port         = var.Aurora_inbound_port
  ip_protocol       = "tcp"
  to_port           = var.Aurora_inbound_port
}

 

## Auto Scaling Group security resource and configutation

resource "aws_security_group" "AutoScalingGroup_SG" {
  name        = "AutoScalingGroup_SG"
  description = "Allow TLS inbound traffic from Application Load Balancer and outbound to Elasticache and Aurora"
  vpc_id      = module.Vpc.Custom_vpc.id

  tags = {
    Name = "AutoScalingGroup_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_ASG_from_ALB" {
  for_each = { for idx , port in var.ASG_inbound_port_for_ALB : idx => port
  }
  security_group_id = aws_security_group.AutoScalingGroup_SG.id
  security_group = [ aws_security_group.ApplicationLoadBalancer_SG.id ]
  from_port         = each.value.port
  ip_protocol       = "tcp"
  to_port           = each.value.port
} 

resource "aws_vpc_security_group_ingress_rule" "AutoscalingGroup_ingress_rules_other" {
  for_each = {
    for rule in var.ASG_inbound_rules :
    "${rule.type}-${rule.port}-${rule.value}" => rule
  }
   from_port         = each.value.port
   ip_protocol       = "tcp"
   to_port           = each.value.port
   security_group_id = aws_security_group.AutoScalingGroup_SG.id
   cidr_blocks = each.value.type == "cidr" ? [each.value.source] : null
   security_group = each.value.type == "sg" ? [each.value.source] : null
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic_ASG_to_Aurora" {
  security_group_id = aws_security_group.AutoScalingGroup_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


## Elastic Cache security resource and configuration


resource "aws_security_group" "ElasticacheVolkey_SG" {
  name        = "ElasticacheVolkey_SG"
  description = "Allow TLS inbound traffic from ASG"
  vpc_id      = module.Vpc.Custom_vpc.id

  tags = {
    Name = "ElasticacheVolkey_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_Volkey" {
  security_group_id = aws_security_group.ElasticacheVolkey_SG.id
  security_group = [aws_security_group.AutoScalingGroup_SG.id]
  from_port         = var.Volkey_inbound_port
  ip_protocol       = "tcp"
  to_port           = var.Volkey_inbound_port
}


## Load Balancer resource and configuration

resource "aws_security_group" "ApplicationLoadBalancer_SG" {
  name        = "ApplicationLoadBalancer_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.Vpc.Custom_vpc.id

  tags = {
    Name = "ApplicationLoadBalancer_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_ALB" {
  security_group_id = aws_security_group.ApplicationLoadBalancer_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ApplicationLoadBalancer_inbound_port
  ip_protocol       = "tcp"
  to_port           = var.ApplicationLoadBalancer_inbound_port
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic_ALB" {
  security_group_id = aws_security_group.ApplicationLoadBalancer_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

