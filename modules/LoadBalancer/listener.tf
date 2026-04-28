resource "aws_lb_listener" "Application_TG_http" {
  
  count = var.Listener_protocol == "HTTP" ? 1: 0

  load_balancer_arn = aws_lb.Application_load_balancer.arn
  port              = var.Listener_port
  protocol          = var.Listener_protocol

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = var.aws_target_group_blue
        weight = 100
      }
     /* target_group {
        arn    = var.aws_target_group_green
        weight = 0
      } */
    }
  }
}

resource "aws_lb_listener" "Application_TG_https" {
  
  count = var.Listener_protocol == "HTTPS" ? 1: 0

  load_balancer_arn = aws_lb.Application_load_balancer.arn
  port              = var.Listener_port
  protocol          = var.Listener_protocol
  ssl_policy        = var.HTTPS_ssl_policy
  certificate_arn  =  var.HTTPS_certificate_arn 
 

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = var.aws_target_group_blue
        weight = 100
      }
      target_group {
        arn    = var.aws_target_group_green
        weight = 0
      }
    }
  }
}