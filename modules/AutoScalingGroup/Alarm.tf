resource "aws_cloudwatch_metric_alarm" "Policy_scaling_alarm_scale_up" {
  alarm_name          = var.Policy_scaling_alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.AutoScaler_application.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.Application_scaling_policy_Scale_out.arn  ]
}


resource "aws_cloudwatch_metric_alarm" "Policy_scaling_alarm_scale_down" {
  alarm_name          = var.Policy_scaling_alarm_cpu_low
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = 60
  statistic   = "Average"

  threshold = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.AutoScaler_application.name
  }

  alarm_actions = [aws_autoscaling_policy.Application_scaling_policy_Scale_in.arn]
}