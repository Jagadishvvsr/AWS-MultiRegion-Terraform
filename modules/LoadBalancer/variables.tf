variable "Environment" {
    description = "Environment of the load balancer"
    type = string
    default = "Dev"
}

variable "Name" {
    description = "name of the load balancer"
    type = string
    default = "Application-load-balancer"
}

variable "Listener_name" {
    description = "name tag for the listener"
    type = string
    default = "Application-blue-listener"
}


variable "security_groups" {
    description = "list of security groups for the load balancer"
    type = list(string)
    default = ["sg-0ec155aeb26b1f673"]
}


variable "subnet_ids" {
    description = "list of subnet ids for the load balancer"
    type = list(string)
    default = ["subnet-084d349a44e1854e1", "subnet-04035f4c858511081", "subnet-0e6c444e98ba29a85"]
}



variable "Listener_port" {
    description = "Listener port number"
    type = number
    default = 80
}

variable "Listener_protocol" {
    description = "Listener portocol"
    type = string
    default = "HTTP"
}

variable "HTTPS_ssl_policy" {
    description = "ssl certificate policy" 
    type = string
    default = null
}

variable "HTTPS_certificate_arn" {
    description = "ssl certificate arn"
    type = string
    default = null

}

variable "aws_target_group_blue" {
    description = "blue target group arn"
    type = string
}

variable "aws_target_group_green" {
    description = "green target group arn"
    type = string
    default = null
}


variable "target_group_blue_weight"{
    description = "live application target group weight"
    type = number
    default = 100
}

variable "target_group_green_weight"{
    description = "Release application target group weight"
    type = number
    default = 0
}

variable "stickiness" {
    description = "enable stickiness"
    type = bool
    default = false
}

variable "stickiness_duration" {
    description = "stickiness duration"
    type = number
    default = 3000
}

variable "idle_timeout" {
    description = "load balancer idle timeout period"
    type = number
    default = 90
}

variable "client_keep_alive" {
    description = "load balancer client http timeout period"
    type = number
    default = 60
}

variable "header_processing" {
    description = "header processing mode"
    type = string
    default = "preserve"
}

variable "desync_mitigation_mode" {
  description = "desync mitigation mode"
  type        = string
  default     = "defensive"

  validation {
    condition = contains(
      ["monitor", "defensive", "strictest"],
      var.desync_mitigation_mode
    )
    error_message = "Must be one of: monitor, defensive, strictest"
  }
}

variable "cross_zone_load_balancing" {
    description = "enable cross zone load balancing"
    type = bool
    default = true
}

variable "enable_deletion_protection" {
    description = "load balancer deletion protection"
    type = bool 
    default = false
}

variable "zonal_shift" {
    description = "enable zonal shift in case of zone degradation"
    type = bool
    default = false
}

variable "access_logs" {
    description = "access logs configuration"
    type = object({
        bucket_name = string
        bucket_prefix = string
        enable = bool
    })
    default = {
        bucket_name = null
        bucket_prefix = null
        enable = false
    }
    
}

variable "connection_logs" {
    description = "connection logs configuration"
    type = object({
        bucket_name = string
        bucket_prefix = string
        enable = bool
    })
    default = {
        bucket_name = null
        bucket_prefix = null
        enable = false
    }
    
}

variable "health_check_logs" {
    description = "health check logs configuration"
    type = object({
        bucket_name = string
        bucket_prefix = string
        enable = bool
    })
    default = {
        bucket_name = null
        bucket_prefix = null
        enable = false
    }
    
}