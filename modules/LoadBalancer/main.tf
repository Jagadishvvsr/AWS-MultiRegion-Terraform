resource "aws_lb" "Application_load_balancer" {
  name               = "${var.Name}-${var.Environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  idle_timeout = var.idle_timeout
  client_keep_alive = var.client_keep_alive

  xff_header_processing_mode = var.header_processing
  desync_mitigation_mode = var.desync_mitigation_mode
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing

  enable_deletion_protection = var.enable_deletion_protection
  enable_zonal_shift = var.zonal_shift

/* access_logs {
    bucket  = var.access_logs.bucket_name
    prefix  = var.access_logs.bucket_prefix
    enabled = var.access_logs.enable
  } 

  connection_logs {
    bucket = var.connection_logs.bucket_name
    prefix = var.connection_logs.bucket_prefix
    enabled = var.connection_logs.enable
  }

  health_check_logs {
    bucket = var.health_check_logs.bucket_name
    prefix = var.health_check_logs.bucket_prefix
    enabled = var.health_check_logs.enable

  } */

  tags = {
    Environment = var.Environment
    Name = var.Name
  }
}
