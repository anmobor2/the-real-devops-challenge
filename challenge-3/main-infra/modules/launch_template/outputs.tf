output "launch_template_id" {
  description = "El ID de la plantilla de lanzamiento creada."
  value       = aws_launch_template.web_server.id
}

output "launch_template_name" {
  description = "El nombre de la plantilla de lanzamiento creada."
  value       = aws_launch_template.web_server.name
}

output "launch_template_latest_version" {
  description = "La última versión de la plantilla de lanzamiento."
  value       = aws_launch_template.web_server.latest_version
}

output "launch_template_arn" {
  description = "El ARN de la plantilla de lanzamiento creada."
  value       = aws_launch_template.web_server.arn
}