output "autoscaling_group_id" {
  description = "ID of the Auto Scaling group"
  value       = aws_autoscaling_group.this.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling group"
  value       = aws_autoscaling_group.this.arn
}


