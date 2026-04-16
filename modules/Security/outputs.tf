output "AutoScalingGroup_SG_Id" {
    value = aws_security_group.AutoScalingGroup_SG.id
}


output "ApplicationLoadBalancer_SG_Id" {
    value = aws_security_group.ApplicationLoadBalancer_SG.id
}

output "Aurora_SG_Id" {
    value = aws_security_group.AuroraGDB_SG.id
}

output "ElasticacheVolkey_SG_Id" {
    value = aws_security_group.ElasticacheVolkey_SG.id
}

