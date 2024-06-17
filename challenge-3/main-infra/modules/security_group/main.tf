/* terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Ajusta la versión según tus necesidades
    }
  }
} */

/* module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.10.0"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"] 

  egress_rules       = ["all-all"] 
  tags = var.tags
} */