resource "aws_elasticache_subnet_group" "cache_subnet_groups" {
  name       = "${var.name}-${var.environment}-subnetgroup"
  subnet_ids = var.cache_subnetgroup_ids
}


resource "aws_elasticache_replication_group" "application_cross_region_replica_primary" {
  replication_group_id          = "${var.name}-${var.environment}-primary"
  description          = "primary replication group for ${var.name}-${var.environment}"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_clusters      = var.num_cache_clusters
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.cache_subnet_groups.name

  security_group_ids  = var.security_group_ids

  preferred_cache_cluster_azs = var.preferred_availability_zones

  transit_encryption_enabled = var.transit_encryption_enabled


  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window = var.snapshot_window

  maintenance_window = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  notification_topic_arn = var.sns_topic_arn

   log_delivery_configuration {
    destination = var.engine_log_configuration.destination
    destination_type      = var.engine_log_configuration.destination_type
    log_format       = var.engine_log_configuration.log_format
    log_type         = "engine-log"
   }

   log_delivery_configuration {
    destination    = var.slow_log_configuration.destination
    destination_type = var.slow_log_configuration.destination_type
    log_format       = var.slow_log_configuration.log_format
    log_type         = "slow-log"
  }

  tags = {
    name = var.name
    environment = var.environment
  }

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

