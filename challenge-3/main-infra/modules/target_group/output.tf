output "target_group" {
  value = {
    name             = aws_lb_target_group.this.name
    backend_protocol = aws_lb_target_group.this.protocol
    backend_port     = aws_lb_target_group.this.port
    target_type      = aws_lb_target_group.this.target_type
    vpc_id           = aws_lb_target_group.this.vpc_id
    create_attachment = true # or false, depending on your requirement
  }
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
  description = "ARN of the target group"
}