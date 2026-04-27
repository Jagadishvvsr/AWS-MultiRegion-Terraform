variable "asg_name" {
    description = "Asg name"
    type = string
    default = "Application_asg"
}

variable "default_instance_warmup"{
    description = "Default instance warmup seconds"
    type = number
    default = 200
 }

variable "subnet_ids" {
  description = "list of subnets"
  type = list(string)
  default = ["subnet-0e6c444e98ba29a85" , "subnet-04035f4c858511081", "subnet-084d349a44e1854e1", "subnet-047cd2924b499baf1", "subnet-09f277e47bbb93b77"]
}

variable "environement" {
    description = "environement of the ASG"
    type = string
    default = "Dev"
}

variable "launch_template" {
    description = "launch template ID"
    type = string
    default = "lt-0f3550fe97f17679c"
}

variable "capacity_rebalance" {
    description = "Capacity rebalance configuration"
    type = bool
    default = true
}

variable "desired_capacity" {
    description = "desired capacity specification"
    type = number
    default = 5
}

variable "max_size" {
    description = "maximum size specification"
    type = number
    default = 20
}


variable "min_size" {
    description = "minimum size specification"
    type = number
    default = 5
}


variable "template_version" {
  description = "template version"
  type = number
  default = 2

}

variable "Scale_out_estimated_warm_out" {
    description = "cool down period after scale out activity"
    type = number
    default = 200
}

variable "Scale_out_estimated_warm_in" {
    description = "cool down period after scale in activity"
    type = number
    default = 200
}

variable "Scale_in_cooldown" {
    description = "cool down period after scale in activity"
    type = number
    default = 300
}




variable "Primary_instance_type" {
    description = "Primary instance type "
    type= string
    default = "m6idn.large"
}

variable "Primary_instance_weight_capacity" {
    description = "Primary instance type weight"
    type= number
    default = 3
}

variable "Secondary_instance_type" {
    description = "Secondary instance type "
    type= string
    default = "r8a.large"
}

variable "Secondary_instance_weight_capacity" {
    description = "Secondary instance type weight"
    type= number
    default = 2
}


variable "health_check_grace_period" {
    description = "health check grace period"
    type = number
    default = 300
}

variable "health_check_type" {
    description = "health check type"
    type = string
    default = "EC2"
}

variable "Policy_scaling_alarm_name" {
    description = "Alarm name"
    type = string
    default = "Policy_scaling_alarm"
} 

variable "Policy_scaling_alarm_cpu_low" {
    description = "name of the scale in alarm"
    type = string
    default = "cpu-low-30"
}

variable "target_group_arns" {
    description = "target group to be provided"
    type = list(string)
}