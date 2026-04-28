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




variable "security_groups" {
    description = "list of security groups for the load balancer"
    type = list(string)
    default = ["sg-08d37cd14dde8f682"]
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
}

variable "HTTPS_certificate_arn" {
    description = "ssl certificate arn"
    type = string

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


