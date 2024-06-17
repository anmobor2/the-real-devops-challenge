# variable "domain_name" {
#   description = "The domain name for the ALB certificate"
#   type        = string
#   default = "*.nip.io"  # Wildcard for all nip.io subdomains
# }

variable "load_balancer_type" {
  description = "Type of load balancer (application or network)"
  type        = string
}

variable "target_groups" {
  type        = map(string)
  description = "Map of target group ARNs"
}

# variable "target_groups" {
#     type = map(object({
#         name             = string
#         backend_protocol = string
#         backend_port     = number
#         target_type      = string
#         vpc_id           = string
#         create_attachment = bool
#     }))
#     description = "List of target group configurations for the ALB"
#     default     = {}
# }

variable "alb_http_tcp_listeners" {
  type = list(object({
    port     = number
    protocol = string
  }))
  description = "List of HTTP/TCP listeners for the ALB"
  default     = [
  {
    port     = 80
    protocol = "HTTP"
  },
  {
    port     = 443
    protocol = "HTTPS"
  }
]  
}

variable "protocol_https" {
  description = "The protocol for the HTTPS listener"
  type        = string
  default = "HTTPS"
  
}

variable "protocol_http" {
  description = "The protocol for the HTTP listener"
  type        = string
  default = "HTTP"
}

variable "port_80" {
  description = "The port for the HTTP listener"
  type        = string
  default = 80
}

variable "port_443" {
  description = "The port for the HTTP listener"
  type        = string
  default = 443
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the ALB"
  type        = string
}

variable "ports_and_protocols" { 
  type = map(object({
    port     = number
    protocol = string
  }))
  description = "List of ports and protocols for the ALB"
  default = {
    "listener_http" = {
      port     = 80
      protocol = "HTTP"
    },
    "listener_https" = {
      port     = 443
      protocol = "HTTPS"
    }
}
}

# NUEVO
variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
}

variable "security_groups" {
  description = "The security groups to attach to the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the ALB resources. A map of tags to assign to the resource"
  type        = map(string)
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "hosted_zone_id" {
  description = "(Optional) The ID of the Route53 hosted zone for DNS validation."
  type        = string
  default     = null
}

variable "health_check_success_codes" {
  description = "The HTTP status codes that are considered a successful response"
  type        = string
  default     = "200"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}