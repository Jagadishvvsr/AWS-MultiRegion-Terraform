resource "aws_autoscaling_policy" "Application_scaling_policy_Scale_out" {
  autoscaling_group_name = aws_autoscaling_group.AutoScaler_application.name
  name                   = "Application-scale-out-policy"
  policy_type            = "StepScaling"

   
  adjustment_type         = "ChangeInCapacity"
  metric_aggregation_type = "Average"
  estimated_instance_warmup = var.Scale_out_estimated_warm_out

 step_adjustment {
    scaling_adjustment          = 3
    metric_interval_lower_bound = 5
    metric_interval_upper_bound = 20
  }

  step_adjustment {
    metric_interval_lower_bound = 20
    scaling_adjustment          = 5
  }
}


resource "aws_autoscaling_policy" "Application_scaling_policy_Scale_in" {
  name                   = "Application-scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.AutoScaler_application.name
  policy_type            = "StepScaling"


  adjustment_type    = "ChangeInCapacity"
  metric_aggregation_type = "Average"
  estimated_instance_warmup = var.Scale_out_estimated_warm_in
  
step_adjustment {
  metric_interval_upper_bound = -20
  scaling_adjustment          = -3
}

step_adjustment {
  metric_interval_lower_bound = -20
  metric_interval_upper_bound = -10
  scaling_adjustment          = -2
}

step_adjustment {
  metric_interval_lower_bound = -10
  metric_interval_upper_bound = 0
  scaling_adjustment          = -1
}

}