variable "Aurora_inbound_port" {
    description = "Inbound port for Aurora"
    type = number
    default = 5432
}

variable "ASG_inbound_port_for_ALB" {
    description = "Inbound port for ASG"
    type = list(number)
    default = [443]
}

variable "ASG_inbound_rules_" {
    description = "Allowing inbound resource to ASG"
    type = map(object({
        type = string  # sg or cidr
        source = string  # sg id or cidr block
        port = number  # port
    }))
    default = {}
}



variable "Volkey_inbound_port" {
    description = "Inbound port for volkey"
    type = number
    default = 6379
}

variable "ApplicationLoadBalancer_inbound_port" {
    description = "Inbound port for volkey"
    type = number
    default = 443
}