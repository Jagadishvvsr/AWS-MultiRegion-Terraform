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
    default = "secondary"
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

variable "availability_zones_primary"{
    description = "availability zones for primary data base"
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_scalability_type_primary" {
    description = "cluster scalabilty type"
    type = string
    default = "standard"
}

variable "iam_database_authentication_enabled_primary"{
    description = "iam database authentication"
    type = bool
    default = false
    
}


variable "iam_roles_primary" {
    description = "List of ARNs for the IAM roles to associate to the RDS Cluster"
    type = list(string)
    default = null
}

variable "iops_primary" {
    description = "Amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster"
    type = string
    default = null
}

variable "monitoring_interval_primary" {
    description = "Interval, in seconds, between points when Enhanced Monitoring metrics"
    type = number
    default = 0
}

variable "monitoring_role_arn_primary" {
    description = "monitoring role for the primary DB"
    type = string
    default = null
}

variable "network_type_primary" {
    description = "network type for primary db"
    type = string
    default = "IPV4"  ##  Valid values: IPV4, DUAL
}

variable "port" {
    description = "port for the database"
    type = number
    default = 6345
}

variable "performance_insights_enabled" {
    description = "performence insights for the database"
    type = bool
    default = false
}

variable "preferred_backup_window"{
    description = "Daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter"
    type = string
    default = "14:00-19:00"
}

variable "preferred_maintenance_window"{
   description = "Weekly time range during which system maintenance can occur, in (UTC)"
   type = string
   default = "wed:04:00-wed:04:30"
}




variable "vpc_security_group_ids_primary" {
    description = "vpc security groups to be associated"
    type = list(string)
    default = [""]
}

variable "database_insights_mode" {
    description = "data base insights"
    type = string
    default = null

}

variable "backup_retention_period" {
    description = " back up retention period in days"
    type = number
    default = 1
}

variable "performance_insights_kms_key_id_primary" {
    description = "kms key id for primary db perfoirmance insight encryption"
    type = string
    default = null
}


variable "performance_insights_retention_period" {
    description = "rentention period for performance insights"
    type = number
    default = 0 
}

variable "engine_mode" {
    description = "engine mode"
    type = string
    default =  "provisioned"
}

variable "enable_local_write_forwarding"{
    description = "enable local write forwarding from read"
    type = bool
    default= false
}

variable "enabled_cloudwatch_logs_exports"{
    description = "enable cloud watch logs"
    type = list(string)
    default = null ##["general" ,"audit", "error", "instance", "postgresql"]
}

variable "auto_minor_version_upgrade" {
    description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
    type = bool
    default = false
}

variable "deletion_protection"{
    description = "deletion protection for database"
    type = bool
    default = false
}

variable "custom_iam_instance_profile_primary" {
    description = "custom instance profile for primary database"
    type = string
    default = null
}

variable "publicly_accessible" {
    description = "public access for database"
    type = bool
    default = false
}