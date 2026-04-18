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
}

variable "capacity_rebalance" {
    description = "Capacity rebalance configuration"
    type = bool
    default = true
}

variable "desired_capacity" {
    description = "desired capacity specification"
    type = number
    default = 2
}

variable "max_size" {
    description = "maximum size specification"
    type = number
    default = 4
}


variable "min_size" {
    description = "minimum size specification"
    type = number
    default = 2
}


variable "template_version" {
  description = "template version"
  type = number
  default = 1

}