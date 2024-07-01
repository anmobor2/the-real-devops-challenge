module "rds" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.6.0"
  name            = var.name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  vpc_id                 = var.vpc_id
  subnets                = var.subnets
  availability_zones     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password

  vpc_security_group_ids = var.vpc_security_group_ids
  tags = var.tags
}

