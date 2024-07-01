# vpc variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_azs" {
  description = "Availability Zones for the VPC"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1c"]
}

variable "rds_azs" {
  description = "Availability Zones for the VPC"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}

variable "vpc_public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateway for the VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to the VPC resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "project_intely"
  }
}

# autoscaling variables
variable "autoscaling_health_check_type" {
  description = "Type of health check to perform"
  type        = string
}

variable "autoscaling_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "autoscaling_user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = ""
}

variable "alb_load_balancer_type" {
  description = "Type of load balancer (application or network)"
  type        = string
  default     = "application"
}

variable "name" {
  description = "Name of the ALB target group"
  type        = string
}

variable "backend_protocol" {
  description = "Protocol for the ALB target group"
  type        = string
}

variable "backend_port" {
  description = "Port for the ALB target group"
  type        = number
}

variable "target_type" {
  description = "Type of target for the ALB target group"
  type        = string
  default     = "instances"
}

variable "alb_http_tcp_listeners" {
  type = list(object({
    port     = number
    protocol = string
  }))
  description = "List of HTTP/TCP listeners for the ALB"
  default = [
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

variable "protocol_http_version" {
  description = "HTTP version for the ALB target group"
  type        = string
  default     = "HTTP1_1"
}

# albgroup variables

variable "alb_security_group_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "project_intely-alb-sg"
}

variable "alb_security_group_description" {
  description = "Description of the ALB security group"
  type        = string
  default     = "Security group for ALB"
}

variable "alb_security_group_ingress_cidr_blocks" {
  description = "CIDR blocks for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_security_group_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    }
  ]
}

variable "alb_security_group_egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # -1 significa "todos los protocolos"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "alb_security_group_rules" {
  description = "A map of ingress/egress rules for the security group"
  type        = map(list(string))
  default = {
    "rule1" = ["80", "80", "tcp", "Allow HTTP traffic"]
    "rule2" = ["443", "443", "tcp", "Allow HTTPS traffic"]
  }
}

variable "alb_security_group_tags" {
  description = "Tags for the ALB security group"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "project_intely"
  }
}

# RDS variables
variable "name_rds" {
  description = "Name of the RDS Aurora cluster"
  type        = string
}


variable "rds_master_password" {
  description = "The master password for the RDS Aurora cluster"
  type        = string
  sensitive   = true
}

variable "rds_tags" {
  description = "A map of tags to apply to the RDS Aurora resources"
  type        = map(string)
  default     = {}
}

variable "rds_master_username" {
  description = "The master username for the RDS Aurora cluster"
  type        = string
  default     = "admin"
}

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
variable "database_name" {
  description = "The name of the database to create"
  type        = string
}
# "aws_launch_template" "web_server"
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
  default     = "user-data.sh"
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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "autoscaling_name" {
  description = "The name of the autoscaling group"
  type        = string
}

variable "autoscaling_instance_type" {
  description = "The instance type for the autoscaling group"
  type        = string
}

variable "autoscaling_ami" {
  description = "The AMI for the autoscaling group"
  type        = string
}

variable "autoscaling_min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
}

variable "autoscaling_max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
}

variable "autoscaling_desired_capacity" {
  description = "The desired capacity of the autoscaling group"
  type        = number
}

variable "autoscaling_tags" {
  description = "Tags for the autoscaling group"
  type        = map(string)
}

variable "alb_name" {
  description = "The name of the load balancer. Name of the ALB"
  type        = string
}

variable "alb_internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
  default     = false
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
}

variable "target_group_name" {
  description = "target group name"
  type        = string
  default     = "project-intely-tg"
}

variable "create_attachment" {
  description = "Whether to create a target group attachment"
  type        = bool
  default     = false

}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "The protocol for the health check"
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "The interval for the health check"
  type        = number
  default     = 5 # this metric is in seconds
}

variable "health_check_timeout" {
  description = "The timeout for the health check"
  type        = number
  default     = 3 # seconds
}

variable "health_check_healthy_threshold" {
  description = "The number of successful checks before considering the target healthy"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "The number of failed checks before considering the target unhealthy"
  type        = number
  default     = 5
}

variable "health_check_matcher" {
  description = "The matcher for the health check"
  type        = string
  default     = "200"
}

variable "listener_port" {
  description = "The port for the listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  type        = string
  default     = "HTTP"
}

variable "alb_tags" {
  description = "A map of tags to assign to the load balancer"
  type        = map(string)
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "security_group_ingress_cidr_blocks" {
  description = "Ingress CIDR blocks for the security group"
  type        = list(string)
}

variable "security_group_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default = {
    Environment = "project_intely"
  }
}

variable "autoscaling_ingress_rules" {
  description = "Ingress rules for the autoscaling security group"
  type = list(object({
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
# sobra
variable "autoscaling_egress_rules" {
  description = "Egress rules for the autoscaling security group"
  type = list(object({
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

variable "autoscaling_ingress_cidr_blocks" {
  description = "Ingress CIDR blocks for the autoscaling security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
# sobra 
variable "instance_tag_name" {
  description = "The name tag for the instances"
  type        = string
  default     = "project_intely"
}

variable "security_group_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    }
  ]
}

variable "security_group_egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # -1 significa "todos los protocolos"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}



#######New config######

variable "create_terraform_state_policy" {
  description = "Whether to create the Terraform state policy"
  type        = bool
  default     = true
}

variable "vpc_availability_zones" {
  description = "Availability zone for the VPC"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}