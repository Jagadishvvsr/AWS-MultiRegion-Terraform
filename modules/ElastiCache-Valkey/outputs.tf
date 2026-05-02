output "Primary_endpoint" {
    value = aws_elasticache_replication_group.application_cross_region_replica_primary.primary_endpoint_address
}

output "primary_reader_endpoint" {
    value = aws_elasticache_replication_group.application_cross_region_replica_primary.reader_endpoint_address
}

output "replica_primary_endpoint" {
    value = aws_elasticache_replication_group.application_secondary_replication_group.primary_endpoint_address
}

output "replica_reader_endpoint" {
    value = aws_elasticache_replication_group.application_secondary_replication_group.reader_endpoint_address
}

output "primary_replica_id"{
    value = aws_elasticache_replication_group.application_cross_region_replica_primary.id
}

output "secondary_replica_id"{
    value = aws_elasticache_replication_group.application_secondary_replication_group.id
}

output "primary_replica_arn" {
    value = aws_elasticache_replication_group.application_cross_region_replica_primary.arn
}

output "secondary_replica_arn" {
    value = aws_elasticache_replication_group.application_secondary_replication_group.arn
}

output "primary_engine_version" {
  value = aws_elasticache_replication_group.application_cross_region_replica_primary.engine_version_actual
}

output "secondary_engine_version" {
  value = aws_elasticache_replication_group.application_secondary_replication_group.engine_version_actual
}

output "global_replication_group_id" {
    value = aws_elasticache_global_replication_group.application_global_replication.id
}

