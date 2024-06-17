variable "launch_template_name_prefix" {
  description = "The prefix for the launch template name"
  type        = string
  default     = "my-template"
}

variable "launch_template_image_id" {
  description = "The AMI ID for the launch template"
  type        = string
  default     = "ami-0c0e147c706360bd7"
}

variable "launch_template_instance_type" {
  description = "The instance type for the launch template"
  type        = string
  default     = "t3.micro"
}

variable "launch_template_user_data_file" {
  description = "The path to the user data script file"
  type        = string
  default     = "user_data.sh"
}

variable "launch_template_tags" {
  description = "Tags to apply to the launch template"
  type        = map(string)
  default = {
    Name        = "project_intely-web-server"
    Terraform   = "true"
    Environment = "project_intely"
  }
}

variable "launch_template_volume_size" {
  description = "The size of the root EBS volume (in GB)"
  type        = number
  default     = 8
}

variable "security_group_id" {
  description = "ID del grupo de seguridad a asociar a la plantilla de lanzamiento"
  type = string
}