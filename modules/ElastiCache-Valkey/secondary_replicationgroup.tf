resource "aws_elasticache_replication_group" "application_secondary_replication_group" {
  provider = aws.secondary

  replication_group_id        = "${var.name}-secondary-${var.environment}"
  description                 = "secondary replication group"
  global_replication_group_id = aws_elasticache_global_replication_group.application_global_replication.global_replication_group_id

   num_cache_clusters        = var.num_cache_clusters
}