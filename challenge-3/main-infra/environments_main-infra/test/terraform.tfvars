vpc_azs = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

#.env variables
rds_master_username = "admin"
rds_master_password = "YourSecurePassword123"
engine              = "aurora-mysql"
engine_version      = "5.7.mysql_aurora.2.11.1"
instance_class      = "db.t3.small"
database_name       = "mydatabase"

#alb tfvars 
alb_name               = "project-intely-alb"
alb_load_balancer_type = "application"

#alb_target_groups = [{
target_group_name = "project-intely-tg"
name              = "project-intely-tg"
backend_protocol  = "HTTP"
backend_port      = 80
target_type       = "instance"
# }]

alb_http_tcp_listeners = [
  {
    port     = 80
    protocol = "HTTP"
  },
  {
    port     = 443
    protocol = "HTTPS"
  }
]

alb_tags = {
  Terraform   = "true"
  Environment = "project_intely"
  Project     = "intely"
}

# alb security group tfvars
alb_security_group_name                = "project-intely-alb-sg"
alb_security_group_description         = "Security group for Project Intely ALB"
alb_security_group_ingress_cidr_blocks = ["0.0.0.0/0"]
alb_security_group_ingress_rules = [{
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow HTTP traffic from anywhere"
}]
alb_security_group_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
]
alb_security_group_tags = {
  Terraform   = "true"
  Environment = "project_intely"
  Project     = "intely"
}

# webserver tfvars
launch_template_name_prefix   = "my-template"
launch_template_image_id      = "ami-0c0e147c706360bd7"
launch_template_instance_type = "t3.micro"
launch_template_tags = {
  Name        = "project_intely-web-server"
  Terraform   = "true"
  Environment = "project_intely"
}
launch_template_volume_size = 1

# rds tfvars
rds_tags = {
  Terraform   = "true"
  Environment = "project_intely"
}

name_rds = "project-intely-db"

# autoscaling tfvars
autoscaling_name                      = "my-asg"
autoscaling_health_check_type         = "EC2"
autoscaling_health_check_grace_period = 300

autoscaling_instance_type = "t3.micro"
autoscaling_ami           = "ami-0c0e147c706360bd7"

autoscaling_min_size         = 1
autoscaling_max_size         = 2
autoscaling_desired_capacity = 1

autoscaling_tags = {
  Terraform   = "true"
  Environment = "project_intely"
}

health_check_healthy_threshold   = 2
health_check_interval            = 5
health_check_path                = "/"
health_check_protocol            = "HTTP"
health_check_timeout             = 3
health_check_unhealthy_threshold = 10
listener_port                    = 80
listener_protocol                = "HTTP"
target_group_port                = 80
target_group_protocol            = "HTTP"

# security group tfvars
security_group_name        = "project-intely-sg"
security_group_description = "Security group for Project Intely"

security_group_ingress_cidr_blocks = ["0.0.0.0/0"]
security_group_ingress_rules = [{
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow HTTP traffic from anywhere"
}]
security_group_egress_rules = [{
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow HTTP traffic from anywhere"
}]
security_group_tags = {
  Terraform   = "true"
  Environment = "project_intely"
}