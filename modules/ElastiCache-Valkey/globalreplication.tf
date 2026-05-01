resource "aws_elasticache_global_replication_group" "application_global_replication" {
  global_replication_group_id_suffix = "${var.name}-global-${var.environment}"
  primary_replication_group_id       = aws_elasticache_replication_group.application_cross_region_replica_primary.id
}
