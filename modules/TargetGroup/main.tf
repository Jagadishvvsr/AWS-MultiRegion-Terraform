resource "aws_lb_target_group" "Application_target_group" {
  name     = "${var.Name}-${var.Environment}"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  deregistration_delay = var.deregistration_delay
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  #slow_start = var.slow_start

  load_balancing_cross_zone_enabled = var.load_balancing_cross_zone_enabled


   stickiness {
    type            = var.stickiness.type
    enabled         = var.stickiness.enabled
    cookie_duration = var.stickiness.cookie_duration
    cookie_name = var.stickiness.type == "app_cookie" ? var.cookie_name : null
  }


  health_check {
    path = var.health_check_path
    protocol = var.protocol
    timeout = var.health_check_timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealth_threshold
    interval = var.health_check_interval
    matcher = var.matcher
  }
}
