variable "Aurora_inbound_port" {
    description = "Inbound port for Aurora"
    type = number
    default = 5432
}

variable "ASG_inbound_port" {
    description = "Inbound port for ASG"
    type = list(number)
    default = [443]
}

variable "Volkey_inbound_port" {
    description = "Inbound port for volkey"
    type = number
    default = 6379
}

variable "ALoadBalancer_inbound_port" {
    description = "Inbound port for volkey"
    type = number
    default = 443
}