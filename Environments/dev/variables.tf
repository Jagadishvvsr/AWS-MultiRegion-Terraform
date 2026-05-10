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


#################################################

############## SECURITY #########################

#################################################


/* variable "Custom_vpc" {
    description = "VPC id"
    type = string
} */
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

variable "ASG_inbound_rules_other" {
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


###################################################

##############TARGET GROUP VARIABLES############## 

###################################################

variable "Environment" {
    description = "Environment of the load balancer"
    type = string
    default = "Dev"
}

variable "Name" {
    description = "name of the load balancer"
    type = string
    default = "App-target-group"
}




/* variable "vpc_id" {
   description = "vpc id for the target group"
   type = string
   default = "vpc-0e217bba014f53293"
  
} */




variable "port" {
    description = "port for the target group"
    type = number
    default = 80
}


variable "protocol" {
    description = "protocol for the target group"
    type = string
    default = "HTTP"
}

variable "health_check_path" {
    description = "health check path on the target server"
    type = string
    default = "/"
}

variable "health_check_timeout" {
    description = "health check timoeut period"
    type = number
    default = 5
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
    default = 30
}


variable "matcher" {
    description = "matcher for target group to consider healthy status"
    type = string
    default = "200"
}


variable "deregistration_delay" {
    description = "deregistration delay period"
    type = number
    default = 300
}

variable "load_balancing_algorithm_type" {
    description = "load balancing algorithm for the target group"
    type = string
    default = "least_outstanding_requests"
}

variable "slow_start" {
    description = "slow start period"
    type = number
    default = 300
}



variable "TG-stickiness" {
    description = "enable/disable stickness"
    type = object({
        type = string
        enabled = bool
        cookie_duration = number
    })

    default = {
        type = "lb_cookie"
        enabled = true
        cookie_duration = 3000
    }
}


variable "cookie_name" {
    description = "cookie name for applciation cookiee"
    type = string
    default = "AWSALB"
}

variable "load_balancing_cross_zone_enabled" {
    description = "cross zone load balancing"
    type = string
    default = "use_load_balancer_configuration"
}


################################################

############ LAUNCH TEMPLATE ###################

################################################


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

/* variable "template_security_group" {
    description = "Security group Id"
    type = string
} */

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




###################################################

#########Auto Scaling Group VARIABLES#############

###################################################


variable "asg_name" {
    description = "Asg name"
    type = string
    default = "Application_asg"
}

variable "default_instance_warmup"{
    description = "Default instance warmup seconds"
    type = number
    default = 200
 }

/* variable "subnet_ids" {
  description = "list of subnets"
  type = list(string)
} */

variable "environement" {
    description = "environement of the ASG"
    type = string
    default = "Dev"
}

variable "launch_template" {
    description = "launch template ID"
    type = string
    default = "lt-0f3550fe97f17679c"
}

variable "capacity_rebalance" {
    description = "Capacity rebalance configuration"
    type = bool
    default = true
}

variable "desired_capacity" {
    description = "desired capacity specification"
    type = number
    default = 5
}

variable "max_size" {
    description = "maximum size specification"
    type = number
    default = 20
}


variable "min_size" {
    description = "minimum size specification"
    type = number
    default = 5
}


variable "template_version" {
  description = "template version"
  type = number

}

variable "Scale_out_estimated_warm_out" {
    description = "cool down period after scale out activity"
    type = number
    default = 200
}

variable "Scale_out_estimated_warm_in" {
    description = "cool down period after scale in activity"
    type = number
    default = 200
}

variable "Scale_in_cooldown" {
    description = "cool down period after scale in activity"
    type = number
    default = 300
}




variable "Primary_instance_type" {
    description = "Primary instance type "
    type= string
    default = "m6idn.large"
}

variable "Primary_instance_weight_capacity" {
    description = "Primary instance type weight"
    type= number
    default = 3
}

variable "Secondary_instance_type" {
    description = "Secondary instance type "
    type= string
    default = "r8a.large"
}

variable "Secondary_instance_weight_capacity" {
    description = "Secondary instance type weight"
    type= number
    default = 2
}


variable "health_check_grace_period" {
    description = "health check grace period"
    type = number
    default = 300
}

variable "health_check_type" {
    description = "health check type"
    type = string
    default = "EC2"
}

variable "Policy_scaling_alarm_name" {
    description = "Alarm name"
    type = string
    default = "Policy_scaling_alarm"
} 

variable "Policy_scaling_alarm_cpu_low" {
    description = "name of the scale in alarm"
    type = string
    default = "cpu-low-30"
}

/* variable "target_group_arns" {
    description = "target group to be provided"
    type = list(string)
} */


##################################################

############# LOAD BALANCER ######################


##################################################

/* variable "Environment" {
    description = "Environment of the load balancer"
    type = string
    default = "Dev"
} */

variable "ApplicationLB-Name" {
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

/* variable "aws_target_group_blue" {
    description = "blue target group arn"
    type = string
} */

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

###############################################

################ CACHE ########################

###############################################

variable "name" {
    description = "Name of the cache cluster-id"
    type = string
    default = "application-cross-region"
}

/* variable "environment" {
    description = "environment for the cache"
    type = string
    default = "dev"
} */

variable "engine" {
    description = "cache engine"
    type = string
    default = "valkey"
}

variable "engine_version" {
    description = "cache engine version"
    type = string
    default = "8.2"

    validation {
     condition     = can(regex("^\\d+\\.\\d+", var.engine_version))
     error_message = "Engine version must be valid semantic version."
  }
}

variable "node_type" {
    description = "cache node type"
    type = string
    default = "cache.c7gn.large"
}


variable "num_cache_clusters" {
    description = "number of cache clusters"
    type = number
    default = 1
}


variable "parameter_group_name" {
    description = "cache parameter paramete"
    type = string
    default = "default.valkey8"
}

variable "Valkey_port" {
    description = "cache port"
    type = number
    default = 6379
} 
 

variable "cache_subnetgroup_ids" {
    description = "cache subnet groups ids"
    type = list(string)
    default = [ "subnet-04035f4c858511081", "subnet-047cd2924b499baf1", "subnet-0a888a7437dfb6550"]
}

variable "preferred_availability_zones" {
    description = "preferred availability zones for cache"
    type = list(string)
    default = ["us-east-1a"] # "us-east-1a", "us-east-1d"
}

variable "transit_encryption_enabled" {
    description = "in transit encryption configuration"
    type = bool 
    default = true
}

variable "security_group_ids" {
    description = "security group ids for the cluster"
    type = list(string)
    default = ["sg-0808c9d229917ac5d"]
}

variable "snapshot_retention_limit" {
    description = "snapshot retention limit in days"
    type = number
    default = 1
}

variable "snapshot_window" {
    description = "window for daily automatic snapshot time range (in UTC)"
    type = string
    default = "03:00-05:00"
}

variable "maintenance_window" {
    description = "maintaince window" #The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). min duration is 60 mins
    type = string
    default = "sun:05:00-sun:09:00"
}

variable "auto_minor_version_upgrade" {
    description = "enable for auto update of minor version on cache"
    type = bool
    default = false
}

variable "sns_topic_arn" {
    description = "sns topic arn for notification from cache"
    type = string
    default = null
}


variable "secondary_region" {
    description = "Region for secondary replication"
    type = string
    default = "us-west-1"
}


variable "slow_log_configuration" {
    description = "slow log configuration"
    type = object({
        destination = string
        destination_type = string
        log_format = string
    })
    default = ({
        destination = "elasticCache"
        destination_type = "cloudwatch-logs"
        log_format = "text"
    })
}

variable "engine_log_configuration" {
    description = "engine log configuration"
    type = object({
        destination = string
        destination_type = string
        log_format = string
    })
    default = ({
        destination = "elasticCache"
        destination_type = "cloudwatch-logs"
        log_format = "text"
    })
}


##################################################

################### Aurora #######################

##################################################

/* variable "Environment" {
    description = "environment"
    type = string
    default = "dev"
}
*/


variable "global_cluster_identifier" {
    description = "identifies for global cluster identifier"
    type = string
    default = "application-global-cluster"
}

variable "Aurora_engine" {
    description = "database engine"
    type = string
    default = "aurora-postgresql"
}

variable "Aurora_engine_version" {
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

variable "Aurora_port" {
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

variable "Aurora_auto_minor_version_upgrade" {
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

variable "secret_kms_key" {
    description = "kms key to encrypt secret"
    type = string
    default = null
}

variable "rotation_rules" {
    description = "days to rotate the secret automatically"
    type = number
    default = 30
}

variable "secret_recovery_window_in_days" {
    description = "recovery of the db secret in days"
    type = number
    default = 0
}

variable "aurora_secret_rotation_role_arn" {
  description = "lamda fucntion rotation role arn"
  type = string
  default = "arn:aws:iam::891612582498:role/aurora_secret_rotation_role"
}

variable "lambda_function_filename"{
    description = "Lambda function zip file name"
    type = string
    default = "test.zip"
}

variable "force_overwrite_replica_secret" {
    description = "force overwrite replica secret"
    type = bool
    default = false
}

variable "secret_replica_region" {
    description = "secret replica region"
    type = string
    default = "us-west-2"
}



variable "Secondary_template_AMI" {
    type = string
}