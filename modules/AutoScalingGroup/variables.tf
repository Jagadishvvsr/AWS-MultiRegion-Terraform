variable "asg_name" {
    description = "Asg name"
    type = string
    default = "Application_asg"
}

variable "environement" {
    description = "environement of the ASG"
    type = string
    default = "Dev"
}

variable "launch_template" {
    description = "launch template ID"
    type = string
    default = "lt-01bf83a957d64c193"
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


variable "Primary_intance_type" {
    description = "Primary instance type "
    type= string
    default = "t3.micro"
}

variable "Primary_intance_weight_capacity" {
    description = "Primary instance type weight"
    type= number
    default = 3
}

variable "Secondary_intance_type" {
    description = "Secondary instance type "
    type= string
    default = "m6id.xlarge"
}

variable "Secondary_intance_weight_capacity" {
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