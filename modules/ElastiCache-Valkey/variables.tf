variable "name" {
    description = "Name of the cache cluster-id"
    type - string
    default = "application_cross_region"
}

variable "environment" {
    description" = "environment for the cache"
    type = string
    default = "dev"
}

variable "engine" {
    description = "cache engine"
    type = string
    default = "valkey"
}

variable "engine_version" {
    description = "cache engine version"
    type = string
    default = "3.2.10"
}

variable "node_type" {
    description = "cache node type"
    type = string
    default = "t3.micro"
}


variable "num_cache_nodes" {
    description = "number of cache nodes"
    type = number
    default = 1
}


variable "parameter_group_name" {
    description = "cache parameter paramete"
    type = string
    default = "default.redis3.2"
}

variable "port" {
    description = "cache port"
    type = number
    default = 6379
}


variable "cache_subnetgroup_ids" {
    description = "cache subnet groups ids"
    type = list(string)
    default = ["", ""]
}

variable "preferred_availability_zones" {
    description = "preferred availability zones for cache"
    type = list(string)
    default = ["", ""]
}

variable "transit_encryption_enabled" {
    description = "in transit encryption configuration"
    type = bool 
    default = false
}

variable "security_group_ids" {
    description = "security group ids for the cluster"
    type = list(string)
    default = ["" ,""]
}

variable "snapshot_retention_limit" {
    description = "snapshot retention limit in days"
    type = number
    default = 1
}

variable "snapshot_window" {
    description = "window for daily automatic snapshot time range (in UTC)"
    type = string
    default = "05:00-09:00"
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

variable "cloudwatch_log_configuration" {
    description = "cloud watch log group configuration for log delivery"
    type = object({
        description = string
        destination_type = string
        log_format = string
        log_type = string
    }
    )
   
}

variable "cloudwatch_log_configuration" {
    description = "cloud watch log group configuration for log delivery"
    type = object({
        destination = string
        destination_type = string
        log_format = string
        log_type = string
    }
    )
   
}

variable "data_firehose_configuration" {
    description = "kenisis data firehose configuration for log delivery"
    type = object({
        destination = string
        destination_type = string
        log_format = string
        log_type = string
    }
    )
   
}

variable "secondary_region" {
    description = "Region for secondary replication"
    type = "string"
    default = "us-west-1"
}