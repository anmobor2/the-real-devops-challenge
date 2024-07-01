#1. Security Group for ALB (Internet -> ALB)
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security Group for Application Load Balancer"

  vpc_id = aws_vpc.toni_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow https request from anywhere"
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }

}

# Security Group for EC2 Instances (ALB -> EC2)
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security Group for Web Server Instances"

  vpc_id = aws_vpc.toni_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

#2. Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet[*].id
  depends_on         = [aws_internet_gateway.igw_vpc]
}

# Target Group for ALB
resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.toni_vpc.id
  tags = {
    Name = "alb_ec2_tg"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "alb-listener"
  }
}

#3. Launch Template for EC2 Instances
resource "aws_launch_template" "ec2_launch_template" {
  name = "web-server"

  image_id      = "ami-0c0e147c706360bd7" //Copy the ami id from aws console
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ec2-web-server"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "ec2_asg" {
  name                = "web-server-asg"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  target_group_arns   = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = aws_subnet.private_subnet[*].id

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  health_check_type = "EC2"

}