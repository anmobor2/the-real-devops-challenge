
# variable "name" {
#   description = "Name of the security group"
#   type        = string
# }

# variable "description" {
#   description = "Description of the security group"
#   type        = string
# }

# variable "vpc_id" {
#   description = "VPC ID where the security group will be created"
#   type        = string
# }

# variable "ingress_cidr_blocks" {
#   description = "List of CIDR blocks allowed to access"
#   type        = list(string)
# }

# variable "ingress_rules" {
#   description = "List of ingress rules"
#   type        = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   default = [{
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }]
# }

# variable "egress_rules" {
#   description = "List of egress rules"
#   type        = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   default = [{
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }]
# }

# variable "tags" {
#   description = "Tags to apply to the security group"
#   type        = map(string)
# }
 