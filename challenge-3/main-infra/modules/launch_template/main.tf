resource "aws_launch_template" "web_server" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  user_data = base64encode(file(abspath("${path.root}/user_data.sh")))
  tags = var.launch_template_tags

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.launch_template_volume_size
    }
  }

  network_interfaces {
    security_groups = [var.security_group_id]
  }
}