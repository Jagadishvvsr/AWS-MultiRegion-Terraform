variable "name" {
    description = "Name of the cache cluster-id"
    type = string
    default = "application-cross-region"
}

variable "environment" {
    description = "environment for the cache"
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
    default = "8.2"

    validation {
     condition     = can(regex("^\\d+\\.\\d+", var.engine_version))
     error_message = "Engine version must be valid semantic version."
  }
}

variable "node_type" {
    description = "cache node type"
    type = string
    default = "cache.m4.xlarge"
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

variable "port" {
    description = "cache port"
    type = number
    default = 6379
}


variable "cache_subnetgroup_ids" {
    description = "cache subnet groups ids"
    type = list(string)
    default = ["subnet-084d349a44e1854e1", "subnet-04035f4c858511081", "subnet-0e6c444e98ba29a85"]
}

variable "preferred_availability_zones" {
    description = "preferred availability zones for cache"
    type = list(string)
    default = ["us-east-1e"] # "us-east-1a", "us-east-1d"
}

variable "transit_encryption_enabled" {
    description = "in transit encryption configuration"
    type = bool 
    default = false
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