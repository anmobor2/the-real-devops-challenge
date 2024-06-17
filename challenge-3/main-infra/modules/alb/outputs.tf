output "alb_arn" {
  value       = aws_lb.this.arn
  description = "ARN of the Application Load Balancer"
}

output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "Zone ID of the Application Load Balancer"
}