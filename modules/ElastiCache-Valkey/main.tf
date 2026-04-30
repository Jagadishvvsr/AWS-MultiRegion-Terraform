resource "aws_elasticache_subnet_group" "cache_subnet_groups" {
  name       = "${name}-subnetgroup-${environment}"
  subnet_ids = var.cache_subnetgroup_ids
}


resource " "aws_elasticache_replication_group" " "application_cross_region_replica_primary" {
  cluster_id           = "${name}-${environment}"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.example.name

  security_group_ids  = var.security_group_ids

  preferred_availability_zones = var.preferred_availability_zones

  transit_encryption_enabled = var.transit_encryption_enabled

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window = var.snapshot_window

  maintenance_window = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  notification_topic_arn = var.sns_topic_arn

   log_delivery_configuration {
    destination      = var.cloudwatch_log_configuration.destination
    destination_type = var.cloudwatch_log_configuration.destination_type
    log_format       = var.cloudwatch_log_configuration.log_format
    log_type         = var.cloudwatch_log_configuration.log_type
   }

   log_delivery_configuration {
    destination    = var.data_firehose_configuration.destination
    destination_type = var.data_firehose_configuration.destination_type
    log_format       = var.data_firehose_configuration.log_format
    log_type         = var.data_firehose_configuration.log_type
  }

  tags = {
    name = var.name
    environment = var.environment
  }
}

