output "load_balancer_dns" {
    value = aws_lb.Application_load_balancer.dns_name
}

output "load_balancer_arn" {
    value = aws_lb.Application_load_balancer.arn
}

output "lb_zone_id" {
  value = aws_lb.Application_load_balancer.zone_id
}

output "http_listener_arn" {
  value = try(aws_lb_listener.Application_TG_http[0].arn, null)
}

output "https_listener_arn" {
  value = try(aws_lb_listener.Application_TG_https[0].arn, null)
}

output "lb_security_groups" {
  value = aws_lb.Application_load_balancer.security_groups
}