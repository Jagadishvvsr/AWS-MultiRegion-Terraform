resource "aws_lb" "Application_load_balancer" {
  name               = "${var.Name}-${var.Environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = false

 /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  } */

  tags = {
    Environment = var.Environment
    Name = var.Name
  }
}
