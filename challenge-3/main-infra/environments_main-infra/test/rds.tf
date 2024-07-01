module "rds" {
  source = "../../modules/rds"

  name           = var.name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  azs            = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

  vpc_id                 = aws_vpc.toni_vpc.id
  subnets                = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id, aws_subnet.private_subnet[2].id]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  database_name   = var.database_name
  master_username = var.rds_master_username
  master_password = var.rds_master_password
  tags            = var.rds_tags

  depends_on = [aws_vpc.toni_vpc]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS instances"
  vpc_id      = aws_vpc.toni_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
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