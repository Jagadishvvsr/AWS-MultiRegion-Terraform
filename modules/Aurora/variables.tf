variable "global_cluster_identifier" {
    description = "identifies for global cluster identifier"
    type = string
    default = "application-global-cluster"
}

variable "engine" {
    description = "database engine"
    type = string
    default = "aurora-postgresql"
}

variable "engine_version" {
    description = "Engine version for postgres"
    type = string
    default = "11.9"
}

variable "database_name" {
    description = "Data base name"
    type = string
    default = "example_db"
}

variable "primary_cluster_identifier" {
    description = "primary cluster identifier"
    type = string
    default = "application-postgres-primary"
}

variable "db_subnet_group_name_primary" {
    description = "database subnet group name"
    type = string
    default = "default"
}

variable "secondary_cluster_identifier" {
    description = "secondary cluster identifier"
    type = string
    default = "application-postgres-secondary"
}

variable "skip_final_snapshot" {
    description = " final snapshot configuration"
    type = bool 
    default = true 
}

variable "db_subnet_group_name_secondary" {
    description = "database subnet group name for secondary cluster accross region"
    type = string
    default = "default"
}


variable "primary_instance_identifier" {
    description = "primary instance identifier"
    type = string
    default = "application-primary-instance"
}

variable "primary_instance_class" {
    description = "primary instance type"
    type = string
    default = "db.r4.large"
}

variable "secondary_instance_identifier" {
    description = "secondary instance identifier"
    type = string
    default = "application-secondary-instance"
}


variable "secondary_instance_class" {
    description = "secondary instance type"
    type = string
    default = "db.r4.large"
}