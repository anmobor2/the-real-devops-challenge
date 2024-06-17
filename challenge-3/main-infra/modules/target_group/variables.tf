variable "name" {
  type        = string
  description = "Name of the target group"
}

variable "backend_port" {
  type        = number
  description = "Port on which targets receive traffic"
}

variable "backend_protocol" {
  type        = string
  description = "Protocol for the target group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "target_type" {
  type        = string
  description = "Type of target for the target group"
}

# Health check variables
variable "health_check_path" {
  type        = string
  description = "Path for the health check"
}

variable "health_check_protocol" {
  type        = string
  description = "Protocol for the health check"
}

variable "health_check_matcher" {
  type        = string
  description = "The HTTP codes to use when checking for a successful response from a target"
}

variable "health_check_interval" {
  description = "The interval for the health check"
  type        = number
}

variable "health_check_timeout" {
  description = "The timeout for the health check"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "The number of successful checks before considering the target healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "The number of failed checks before considering the target unhealthy"
  type        = number
}