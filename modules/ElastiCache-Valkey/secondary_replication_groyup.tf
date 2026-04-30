resource "aws_elasticache_replication_group" "application_secondary_replication_group" {
  provider = var.secondary_region

  replication_group_id        = "${var.name}-secondarygroup-${aws.region}-${environment}"
  description                 = "secondary replication group"
  global_replication_group_id = aws_elasticache_global_replication_group.application_global_replication.global_replication_group_id

  num_cache_nodes      = var.num_cache_nodes
}