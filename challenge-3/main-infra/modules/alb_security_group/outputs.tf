output "alb_security_group_id" {
  description = "ID of the security group"
  value       = module.alb_security_group.security_group_id
}

output "alb_security_group_name" {
  description = "Name of the security group"
  value       = module.alb_security_group.security_group_name
}

output "alb_security_group_arn" {
  description = "ARN of the security group"
  value       = module.alb_security_group.security_group_arn
}
