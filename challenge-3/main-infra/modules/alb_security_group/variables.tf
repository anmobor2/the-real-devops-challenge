variable "name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "description" {
  description = "Description of the ALB security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks for ingress rules"
  type        = list(string)
}

variable "ingress_rules" {
  description = "Ingress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "egress_rules" {
  description = "Egress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "rules" {
  description = "A map of ingress/egress rules for the security group"
  type = map(list(string))
  default = {
    "rule1" = ["80", "80", "tcp", "Allow HTTP traffic"]
    "rule2" = ["443", "443", "tcp", "Allow HTTPS traffic"]
  }
}

variable "tags" {
  description = "Tags for the ALB security group"
  type        = map(string)
}