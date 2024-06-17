# RDS variables
variable "rds_instance_class" {
  description = "The instance class for the RDS Aurora instances"
  type        = string
  default     = "db.t2.small"
}

variable "rds_engine" {
  description = "The database engine for the RDS Aurora instances"
  type        = string
  default     = "aurora-mysql"
}

variable "rds_engine_version" {
  description = "The database engine version for the RDS Aurora instances"
  type        = string
  default     = "5.7.mysql_aurora.2.07.2"
}

variable "rds_tags" {
  description = "A map of tags to apply to the RDS Aurora instances"
  type        = map(string)
  default     = {}
}

variable "launch_template" {
  type = object({
    id      = string
    version = string
  })
  description = "Launch template configuration"
}

# nuevo
variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
}

variable "target_group_arns" {
  description = "A list of ARNs for the target groups to use"
  type        = list(string)
}

variable "launch_template_id" {
  description = "The ID of the launch template"
  type        = string
}

variable "launch_template_version" {
  description = "The version of the launch template"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}

variable "ingress_rules" {
  description = "Ingress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "Egress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "instance_tag_name" {
  description = "Tags to assign to the Auto Scaling group"
  type        = string
}

variable "name" {
  description = "Name of the Auto Scaling group"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "health_check_type" {
  description = "Type of health check for the Auto Scaling group"
  type        = string
}

variable "health_check_grace_period" {
  description = "Grace period for health checks"
  type        = number
}

variable "subnet_ids" {
  description = "Lista de IDs de las subredes privadas donde se creará el grupo de subredes de la base de datos."
  type        = list(string)
}