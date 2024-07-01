variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
}

variable "instance_class" {
  description = "The instance class to use"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to create the resources in"
  type        = string
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "subnets" {
  description = "The subnet IDs to create the resources in"
  type        = list(string)
}

variable "create_security_group" {
  description = "Whether to create a security group for the RDS cluster"
  type        = bool
  default     = true
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
  default     = "admin"
}

variable "master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of the RDS cluster"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The security group IDs to associate with the RDS cluster"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones for the VPC"
  type        = list(string)
}