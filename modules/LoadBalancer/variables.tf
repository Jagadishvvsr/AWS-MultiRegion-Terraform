variable "Environment" {
    description = "Environment of the load balancer"
    type = string
    default = "Dev"
}

variable "Name" {
    description = "name of the load balancer"
    type = string
    default = "Application_load_balancer"
}

variable "security_groups" {
    description = "name of the load balancer"
    type = list(string)
    default = ["", "", ""]
}


variable "security_groups" {
    description = "list of security groups for the load balancer"
    type = list(string)
    default = ["", "", ""]
}


variable "subnet_ids" {
    description = "list of subnet ids for the load balancer"
    type = list(string)
    default = ["", "", ""]
}


variable "port" {
    description = "port for the target group"
    type = number
    default = 80
}


variable "protocol" {
    description = "protocol for the target group"
    type = string
    default = HTTP
}

variable "health_check_path" {
    description = "health check path on the target server"
    type = string
    default = "/"
}

variable "health_check_timeout" {
    description = "health check timoeut period"
    type = number
    default = 300
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
    default = 300
}


variable "matcher" {
    description = "matcher for target group to consider healthy status"
    type = list(number)
    default = [200]
}


variable "deregistration_delay" {
    description = "deregistration delay period"
    type = number
    default = 300
}

variable "load_balancing_algorithm_type" {
    description = "load balancing algorithm for the target group"
    type = string
    default = " weighted_random"
}

variable "slow_start" {
    description = "slow start period"
    type = number
    default = 300
}

variable "stickiness" {
    description = "enable/disable stickness"
    type = boolean
    default = true
}


variable "load_balancing_cross_zone_enabled" {
    description = "cross zone load balancing"
    type = string
    default = "use_load_balancer_configuration"
}