output "global_cluster_id" {
  value = aws_rds_global_cluster.application_global_cluster_rds.id
}

output "global_cluster_arn" {
  value = aws_rds_global_cluster.application_global_cluster_rds.arn
}

output "engine" {
  value = aws_rds_global_cluster.application_global_cluster_rds.engine
}

output "engine_version" {
  value = aws_rds_global_cluster.application_global_cluster_rds.engine_version
}


output "primary_cluster_id" {
  value = aws_rds_cluster.primary_cluster.id
}

output "primary_cluster_arn" {
  value = aws_rds_cluster.primary_cluster.arn
}


output "primary_writer_endpoint" {
  value = aws_rds_cluster.primary_cluster.endpoint
}

output "primary_reader_endpoint" {
  value = aws_rds_cluster.primary_cluster.reader_endpoint
}

output "primary_instance_id" {
  value = aws_rds_cluster_instance.primary.id
}


output "secondary_cluster_id" {
  value = aws_rds_cluster.secondary_cluster.id
}

output "secondary_cluster_arn" {
  value = aws_rds_cluster.secondary_cluster.arn
}

output "secondary_reader_endpoint" {
  value = aws_rds_cluster.secondary_cluster.endpoint
}

output "secondary_writer_endpoint" {
  value = aws_rds_cluster.secondary_cluster.endpoint
}


output "secondary_instance_id" {
  value = aws_rds_cluster_instance.secondary.id
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}

output "db_secret_name" {
  value = aws_secretsmanager_secret.db_secret.name
}

output "db_secret_id" {
    value = aws_secretsmanager_secret.db_secret.id
}

/* output "db_secret_replica_arn" {
  value = data.aws_secretsmanager_secret.replica_db.arn
}

output "db_secret_replica_id" {
  value = data.aws_secretsmanager_secret.replica_db.id
} */