resource "aws_autoscaling_group" "this" {
  name                 = var.name
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = var.target_group_arns
  health_check_type    = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key                 = var.instance_tag_name
    value               = var.instance_tag_name
    propagate_at_launch = true
  }
}