terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  name                = var.vpc_name
  cidr                = var.vpc_cidr
  azs                 = var.vpc_azs
  public_subnets      = var.vpc_public_subnets
  private_subnets     = var.vpc_private_subnets
  enable_nat_gateway  = var.vpc_enable_nat_gateway
  tags                = var.vpc_tags
}

module "autoscaling" {
  source = "./modules/autoscaling"

  # Atributos básicos del ASG
  name                 = var.autoscaling_name
  min_size             = var.autoscaling_min_size
  max_size             = var.autoscaling_max_size
  desired_capacity     = var.autoscaling_desired_capacity
  # Atributo adicional para el ASG
  vpc_zone_identifier  = module.vpc.private_subnets
  health_check_type   = var.autoscaling_health_check_type
  health_check_grace_period = var.autoscaling_health_check_grace_period
  # Referencias a otros recursos
  launch_template_id = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version
  subnet_ids          = module.vpc.private_subnets
#  target_group_arns    = module.alb.target_group_arns

  target_group_arns = [
    module.target_group_http.target_group_arn,
    module.target_group_https.target_group_arn
  ]

  launch_template = {
    id      = module.launch_template.launch_template_id
    version = module.launch_template.launch_template_latest_version
  }

  ingress_rules = var.security_group_ingress_rules 
  egress_rules  = var.security_group_egress_rules

  tags = var.autoscaling_tags

  instance_tag_name = var.instance_tag_name
  depends_on = [module.vpc]
}

module "launch_template" {
  source = "./modules/launch_template"

  launch_template_name_prefix = var.launch_template_name_prefix
  launch_template_image_id = var.launch_template_image_id
  launch_template_instance_type = var.launch_template_instance_type
  launch_template_user_data_file = base64encode(file(abspath("${path.root}/user_data.sh")))
  launch_template_volume_size = 1
  launch_template_tags = var.launch_template_tags
  security_group_id = module.alb_security_group.alb_security_group_id
}

module "alb" {
  source = "./modules/alb"
  
  name               = var.alb_name
  internal           = var.alb_internal
  security_groups    = [module.alb_security_group.alb_security_group_id]
  subnets            = module.vpc.public_subnets
  target_group_port  = var.target_group_port
  target_group_protocol = var.target_group_protocol
  vpc_id             = module.vpc.vpc_id

  tags               = var.alb_tags

  load_balancer_type = var.alb_load_balancer_type

  target_groups = {
    "project-intely-tg" = module.target_group_http.target_group_arn,
    "project-intely-tg-https" = module.target_group_https.target_group_arn
  }

  depends_on = [module.vpc]
  alb_http_tcp_listeners = var.alb_http_tcp_listeners
  security_group_id = module.alb_security_group.alb_security_group_id
  vpc_cidr = var.vpc_cidr
  #domain_name = "192-168-1-100.nip.io"
}

  module "target_group_http" {
  source = "./modules/target_group"

  name                = "project-intely-tg"
  backend_port        = var.backend_port
  backend_protocol    = var.backend_protocol
  vpc_id              = module.vpc.vpc_id
  target_type         = var.target_type
  health_check_path   = var.health_check_path
  health_check_protocol = var.health_check_protocol
  health_check_matcher = var.health_check_matcher

  health_check_interval = var.health_check_interval
  health_check_timeout  = var.health_check_timeout
  health_check_healthy_threshold = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
}

module "target_group_https" {
  source = "./modules/target_group"

  name                = "project-intely-tg-https"
  backend_port        = 443
  backend_protocol    = "HTTPS"
  vpc_id              = module.vpc.vpc_id
  target_type         = var.target_type
  health_check_path   = var.health_check_path
  health_check_protocol = var.health_check_protocol
  health_check_matcher = var.health_check_matcher

  health_check_interval = var.health_check_interval
  health_check_timeout  = var.health_check_timeout
  health_check_healthy_threshold = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
}
  


module "alb_security_group" {
  source = "./modules/alb_security_group"

  name        = var.alb_security_group_name
  description = var.alb_security_group_description
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.alb_security_group_ingress_cidr_blocks

  tags = var.alb_security_group_tags
}

module "rds" {
  source = "./modules/rds"
#  count              = length(var.vpc_azs) # Una subred por cada AZ
#  name        = "${var.name}-subnet-group-${count.index}" # Nombre único por subred
  name               = var.name
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets

  database_name      = var.database_name
  master_username    = var.rds_master_username
  master_password    = var.rds_master_password
  tags               = var.rds_tags
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {  # Security group for RDS
  name        = "rds-security-group"
  description = "Security group for RDS instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306  
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.alb_security_group.alb_security_group_id] # Allow traffic from ALB security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

output "launch_template_id" {
  value = module.launch_template.launch_template_id
}

output "launch_template_version" {
  value = module.launch_template.launch_template_latest_version
}