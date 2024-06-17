variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones for the VPC"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for the VPC"
  type        = bool
}

# Nuevo

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}