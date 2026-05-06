variable "Vpc_Cidr_Block" {
     description = "This is VPC cidr block"
     type= string
     default = "10.0.0.0/16"
   
   }

variable "public_subnets" {
  description = "List of subnets to create"
  type = list(object({
    cidr = optional(string)
    az   = optional(string)
  }))
  default = []
}

variable "private_subnets" {
  description = "List of private subnets to create"
  type = list(object({
    cidr = optional(string)
    az = optional(string)
  }))
  default = []
}

variable "public_subnet_count" {
    description = "no of public subnet"
    type = number
    default = 0
}

variable "private_subnet_count" {
    description = "no of private subnet"
    type = number
    default = 0
}


/* varaible "Vpc_region" {
    description = "VPC region"
    type = String
    default = "us-east-1"
} */

variable "instance_tenancy" {
    description = "Tenancy for the vpc hosts"
    type = string
    default = "default"
}

variable "enable_dns_hostnames" {
   description = "enable dns hostnames"
   type = bool
   default = false

}

variable "enable_dns_support" {
   description = "enable dns support"
   type = bool
   default = false

}

variable "private_offset" {
  default = 100
}



###################################################

##############TARGET GROUP VARIABLES############## 

###################################################

variable "Environment" {
    description = "Environment of the load balancer"
    type = string
    default = "Dev"
}

variable "Name" {
    description = "name of the load balancer"
    type = string
    default = "Application-target-group"
}




variable "vpc_id" {
   description = "vpc id for the target group"
   type = string
   default = "vpc-0e217bba014f53293"
  
}




variable "port" {
    description = "port for the target group"
    type = number
    default = 80
}


variable "protocol" {
    description = "protocol for the target group"
    type = string
    default = "HTTP"
}

variable "health_check_path" {
    description = "health check path on the target server"
    type = string
    default = "/"
}

variable "health_check_timeout" {
    description = "health check timoeut period"
    type = number
    default = 5
}

variable "unhealth_threshold" {
    description = "unhealthy threshold"
    type = number
    default = 3
}


variable "healthy_threshold" {
    description = "healthy threshold"
    type = number
    default = 2
}


variable "health_check_interval" {
    description = "health check interval"
    type = number
    default = 30
}


variable "matcher" {
    description = "matcher for target group to consider healthy status"
    type = string
    default = "200"
}


variable "deregistration_delay" {
    description = "deregistration delay period"
    type = number
    default = 300
}

variable "load_balancing_algorithm_type" {
    description = "load balancing algorithm for the target group"
    type = string
    default = "least_outstanding_requests"
}

variable "slow_start" {
    description = "slow start period"
    type = number
    default = 300
}



variable "stickiness" {
    description = "enable/disable stickness"
    type = object({
        type = string
        enabled = bool
        cookie_duration = number
    })

    default = {
        type = "lb_cookie"
        enabled = true
        cookie_duration = 3000
    }
}


variable "cookie_name" {
    description = "cookie name for applciation cookiee"
    type = string
    default = "AWSALB"
}

variable "load_balancing_cross_zone_enabled" {
    description = "cross zone load balancing"
    type = string
    default = "use_load_balancer_configuration"
}




###################################################

#########Auto Scaling Group VARIABLES#############

###################################################


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