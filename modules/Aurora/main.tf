
resource "aws_rds_global_cluster" "application_global_cluster_rds" {
  global_cluster_identifier = var.global_cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  database_name             = var.database_name
}

resource "aws_rds_cluster" "primary_cluster" {
  #provider                  = aws.primary

  port = var.port
  cluster_scalability_type = var.cluster_scalability_type_primary
  engine                    = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version            = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  cluster_identifier        = var.primary_cluster_identifier
  master_username           = "username"
  master_password           = "somepass123"
  database_name             = "example_db"
  global_cluster_identifier = aws_rds_global_cluster.application_global_cluster_rds.id
  db_subnet_group_name      = var.db_subnet_group_name_primary
  availability_zones = var.availability_zones_primary
  
  iam_database_authentication_enabled = var.iam_database_authentication_enabled_primary
 
  iam_roles = var.iam_roles_primary
  engine_mode = var.engine_mode

  iops = var.iops_primary
  monitoring_interval = var.monitoring_interval_primary
  monitoring_role_arn  = var.monitoring_role_arn_primary
  network_type = var.network_type_primary


  performance_insights_enabled = var.performance_insights_enabled

  database_insights_mode  = var.database_insights_mode

  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window


  performance_insights_retention_period = var.performance_insights_retention_period
  skip_final_snapshot = var.skip_final_snapshot

  vpc_security_group_ids = var.vpc_security_group_ids_primary

  backup_retention_period = var.backup_retention_period
  
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  enable_local_write_forwarding = var.enable_local_write_forwarding

  deletion_protection = var.deletion_protection

 /* restore_to_point_in_time {
    source_cluster_identifier  = aws_rds_cluster.secondary_cluster.id
    restore_type               = "copy-on-write"
    use_latest_restorable_time = true
  } */

  performance_insights_kms_key_id = var.performance_insights_kms_key_id_primary

}

resource "aws_rds_cluster_instance" "primary" {
  # provider             = aws.primary
  engine               = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version       = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  identifier           = var.primary_instance_identifier
  cluster_identifier   = aws_rds_cluster.primary_cluster.id
  instance_class       = var.primary_instance_class
  db_subnet_group_name = var.db_subnet_group_name_primary

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  custom_iam_instance_profile = var.custom_iam_instance_profile_primary
  publicly_accessible = var.publicly_accessible

}


resource "aws_rds_cluster" "secondary_cluster" {
  provider                  = aws.secondary
  engine                    = aws_rds_global_cluster.application_global_cluster_rds.engine
  replication_source_identifier = aws_rds_cluster.primary_cluster.id
  engine_version            = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  cluster_identifier        = var.secondary_cluster_identifier
  global_cluster_identifier = aws_rds_global_cluster.application_global_cluster_rds.id
  skip_final_snapshot       = var.skip_final_snapshot
  db_subnet_group_name      = var.db_subnet_group_name_secondary

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  enable_local_write_forwarding = var.enable_local_write_forwarding

  lifecycle {
    ignore_changes = [
      replication_source_identifier
    ]
  }

  depends_on = [
    aws_rds_cluster_instance.primary
  ]
}

resource "aws_rds_cluster_instance" "secondary" {
  provider             = aws.secondary
  engine               = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version       = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  identifier           = var.secondary_instance_identifier
  cluster_identifier   = aws_rds_cluster.secondary_cluster.id
  instance_class       = var.secondary_instance_class
  db_subnet_group_name = var.db_subnet_group_name_secondary
}