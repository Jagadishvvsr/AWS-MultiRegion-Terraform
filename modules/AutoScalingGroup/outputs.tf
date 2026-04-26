output "ASG-ID" {
    value = aws_autoscaling_group.AutoScaler_application.id
}

output "Alarm_scale_down" {
    value = aws_cloudwatch_metric_alarm.Policy_scaling_alarm_scale_down.id
}

output "Alarm_scale_up" {
    value = aws_cloudwatch_metric_alarm.Policy_scaling_alarm_scale_up.id
}

output "Application_scaling_policy_out_ASG" {
    value = aws_autoscaling_policy.Application_scaling_policy_Scale_out.id
}

output "Application_scaling_policy_Scale_in_ASG" {
    value = aws_autoscaling_policy.Application_scaling_policy_Scale_in.id
}