resource "aws_lb_target_group" "this" {
  name                 = var.name
  port                 = var.backend_port
  protocol             = var.backend_protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }
}
