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