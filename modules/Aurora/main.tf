
resource "aws_rds_global_cluster" "application_global_cluster_rds" {
  global_cluster_identifier = var.global_cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  database_name             = var.database_name
}

resource "aws_rds_cluster" "primary_cluster" {
  #provider                  = aws.primary
  engine                    = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version            = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  cluster_identifier        = var.primary_cluster_identifier
  master_username           = "username"
  master_password           = "somepass123"
  database_name             = "example_db"
  global_cluster_identifier = aws_rds_global_cluster.application_global_cluster_rds.id
  db_subnet_group_name      = var.db_subnet_group_name_primary
}

resource "aws_rds_cluster_instance" "primary" {
  # provider             = aws.primary
  engine               = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version       = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  identifier           = var.primary_instance_identifier
  cluster_identifier   = aws_rds_cluster.primary_cluster.id
  instance_class       = var.primary_instance_class
  db_subnet_group_name = var.db_subnet_group_name_primary
}

resource "aws_rds_cluster" "secondary_cluster" {
  provider                  = aws.secondary
  engine                    = aws_rds_global_cluster.application_global_cluster_rds.engine
  engine_version            = aws_rds_global_cluster.application_global_cluster_rds.engine_version
  cluster_identifier        = var.secondary_cluster_identifier
  global_cluster_identifier = aws_rds_global_cluster.application_global_cluster_rds.id
  skip_final_snapshot       = var.skip_final_snapshot
  db_subnet_group_name      = var.db_subnet_group_name_secondary

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