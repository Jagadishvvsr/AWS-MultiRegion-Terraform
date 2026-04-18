variable "environment" {
    description = "Environment of the Template"
    type = string
    default = "dev"
}

variable "Template_name" {
    description = "name of the template"
    type = string
    default = "Application-TL"
}


variable "template_AMI" {
    description = "blue launch template"
    type = string 
    default = "ami-0ec10929233384c7f"
   
}

variable "instance_type" {
    description = "Live instance type "
    type = string
    default = "t3.micro"
}

variable "instance_profile" {
    description = "Live instance profile "
    type = string
    default = null
} 

variable "template_security_group" {
    description = "Security group Id"
    type = string
    default = "sg-01c5c288dffd88804"
}

variable "create_key" {
  type    = bool
  default = false
}

variable "public_key_path" {
    description = "key file to upload to the instance for access"
    type = string
    default = null
}

variable "instance_keyname" {
     description = "key for instances"
     type = string
     default = "ansible"
}


variable "user_data" {
   description = "Path user data file for the instance"
   type = string
   default = "Scripts/user_data.sh"
}


variable "metadata_hop_limit" {
    description = "Metadata http put response hop limit"
    type = number
    default = 1
}




