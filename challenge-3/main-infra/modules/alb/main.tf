resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  security_groups    = var.security_groups
  subnets            = var.subnets

  load_balancer_type = var.load_balancer_type

  tags = var.tags

}

# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr
# }

# resource "aws_lb_target_group" "this" {

#   for_each = var.target_groups

#   name             = each.value.name
#   port             = each.value.backend_port
#   protocol         = each.value.backend_protocol
#   vpc_id           = each.value.vpc_id
#   target_type      = each.value.target_type

  # depends_on = [
  #   aws_lb_target_group.this
  # ]

 # health_check {
  #   path                = var.health_check_path
  #   protocol            = var.health_check_protocol
  #   interval            = var.health_check_interval
  #   timeout             = var.health_check_timeout
  #   healthy_threshold   = var.health_check_healthy_threshold
  #   unhealthy_threshold = var.health_check_unhealthy_threshold
#  }
#}

resource "aws_lb_listener" "http" {
  for_each          = { for listener in var.alb_http_tcp_listeners: listener.port => listener if listener.protocol == "HTTP" }
  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target_groups["project-intely-tg"]
  }
}

resource "aws_lb_listener" "https" {
  for_each = { for listener in var.alb_http_tcp_listeners: listener.port => listener if listener.protocol == "HTTPS" }
  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol

  certificate_arn = aws_acm_certificate.cert.arn
  ssl_policy      = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = var.target_groups["project-intely-tg-https"]
  }
}

resource "tls_private_key" "cert" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_cert_request" "cert" {
  private_key_pem = tls_private_key.cert.private_key_pem

  subject {
    common_name  = "project-intely.com"
    organization = "Test Organization"
  }
}

resource "tls_locally_signed_cert" "cert" {
  cert_request_pem   = tls_cert_request.cert.cert_request_pem
  ca_private_key_pem = tls_private_key.cert.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 8760 # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.cert.private_key_pem

  subject {
    common_name  = "project-intely.com"
    organization = "Terraform Testing"
  }

  validity_period_hours = 8760 # 1 year

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]

  is_ca_certificate = true
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.cert.private_key_pem
  certificate_body = tls_locally_signed_cert.cert.cert_pem
}