<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.53.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module_alb) | ./modules/alb | n/a |
| <a name="module_alb_security_group"></a> [alb_security_group](#module_alb_security_group) | ./modules/alb_security_group | n/a |
| <a name="module_autoscaling"></a> [autoscaling](#module_autoscaling) | ./modules/autoscaling | n/a |
| <a name="module_launch_template"></a> [launch_template](#module_launch_template) | ./modules/launch_template | n/a |
| <a name="module_rds"></a> [rds](#module_rds) | ./modules/rds | n/a |
| <a name="module_target_group_http"></a> [target_group_http](#module_target_group_http) | ./modules/target_group | n/a |
| <a name="module_target_group_https"></a> [target_group_https](#module_target_group_https) | ./modules/target_group | n/a |
| <a name="module_vpc"></a> [vpc](#module_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb_name](#input_alb_name) | The name of the load balancer. Name of the ALB | `string` | n/a | yes |
| <a name="input_alb_tags"></a> [alb_tags](#input_alb_tags) | A map of tags to assign to the load balancer | `map(string)` | n/a | yes |
| <a name="input_autoscaling_ami"></a> [autoscaling_ami](#input_autoscaling_ami) | The AMI for the autoscaling group | `string` | n/a | yes |
| <a name="input_autoscaling_desired_capacity"></a> [autoscaling_desired_capacity](#input_autoscaling_desired_capacity) | The desired capacity of the autoscaling group | `number` | n/a | yes |
| <a name="input_autoscaling_instance_type"></a> [autoscaling_instance_type](#input_autoscaling_instance_type) | The instance type for the autoscaling group | `string` | n/a | yes |
| <a name="input_autoscaling_max_size"></a> [autoscaling_max_size](#input_autoscaling_max_size) | The maximum size of the autoscaling group | `number` | n/a | yes |
| <a name="input_autoscaling_min_size"></a> [autoscaling_min_size](#input_autoscaling_min_size) | The minimum size of the autoscaling group | `number` | n/a | yes |
| <a name="input_autoscaling_name"></a> [autoscaling_name](#input_autoscaling_name) | The name of the autoscaling group | `string` | n/a | yes |
| <a name="input_autoscaling_tags"></a> [autoscaling_tags](#input_autoscaling_tags) | Tags for the autoscaling group | `map(string)` | n/a | yes |
| <a name="input_backend_port"></a> [backend_port](#input_backend_port) | Port for the ALB target group | `number` | n/a | yes |
| <a name="input_backend_protocol"></a> [backend_protocol](#input_backend_protocol) | Protocol for the ALB target group | `string` | n/a | yes |
| <a name="input_database_name"></a> [database_name](#input_database_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_engine"></a> [engine](#input_engine) | The database engine to use | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine_version](#input_engine_version) | The database engine version | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance_class](#input_instance_class) | The instance class to use | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | Name of the ALB target group | `string` | n/a | yes |
| <a name="input_name_rds"></a> [name_rds](#input_name_rds) | Name of the RDS Aurora cluster | `string` | n/a | yes |
| <a name="input_rds_master_password"></a> [rds_master_password](#input_rds_master_password) | The master password for the RDS Aurora cluster | `string` | n/a | yes |
| <a name="input_security_group_description"></a> [security_group_description](#input_security_group_description) | The description of the security group | `string` | n/a | yes |
| <a name="input_security_group_ingress_cidr_blocks"></a> [security_group_ingress_cidr_blocks](#input_security_group_ingress_cidr_blocks) | Ingress CIDR blocks for the security group | `list(string)` | n/a | yes |
| <a name="input_security_group_name"></a> [security_group_name](#input_security_group_name) | The name of the security group | `string` | n/a | yes |
| <a name="input_target_group_protocol"></a> [target_group_protocol](#input_target_group_protocol) | The protocol for the target group | `string` | n/a | yes |
| <a name="input_target_type"></a> [target_type](#input_target_type) | Type of target for the ALB target group | `string` | n/a | yes |
| <a name="input_alb_http_tcp_listeners"></a> [alb_http_tcp_listeners](#input_alb_http_tcp_listeners) | List of HTTP/TCP listeners for the ALB | <pre>list(object({<br>    port     = number<br>    protocol = string<br>  }))</pre> | <pre>[<br>  {<br>    "port": 80,<br>    "protocol": "HTTP"<br>  },<br>  {<br>    "port": 443,<br>    "protocol": "HTTPS"<br>  }<br>]</pre> | no |
| <a name="input_alb_internal"></a> [alb_internal](#input_alb_internal) | Whether the load balancer is internal or external | `bool` | `false` | no |
| <a name="input_alb_load_balancer_type"></a> [alb_load_balancer_type](#input_alb_load_balancer_type) | Type of load balancer (application or network) | `string` | `"application"` | no |
| <a name="input_alb_security_group_description"></a> [alb_security_group_description](#input_alb_security_group_description) | Description of the ALB security group | `string` | `"Security group for ALB"` | no |
| <a name="input_alb_security_group_egress_rules"></a> [alb_security_group_egress_rules](#input_alb_security_group_egress_rules) | Egress rules for the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>    description = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all outbound traffic",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_alb_security_group_ingress_cidr_blocks"></a> [alb_security_group_ingress_cidr_blocks](#input_alb_security_group_ingress_cidr_blocks) | CIDR blocks for ingress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_alb_security_group_ingress_rules"></a> [alb_security_group_ingress_rules](#input_alb_security_group_ingress_rules) | Ingress rules for the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>    description = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow HTTP from anywhere",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow HTTPS from anywhere",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>]</pre> | no |
| <a name="input_alb_security_group_name"></a> [alb_security_group_name](#input_alb_security_group_name) | Name of the ALB security group | `string` | `"project_intely-alb-sg"` | no |
| <a name="input_alb_security_group_rules"></a> [alb_security_group_rules](#input_alb_security_group_rules) | A map of ingress/egress rules for the security group | `map(list(string))` | <pre>{<br>  "rule1": [<br>    "80",<br>    "80",<br>    "tcp",<br>    "Allow HTTP traffic"<br>  ],<br>  "rule2": [<br>    "443",<br>    "443",<br>    "tcp",<br>    "Allow HTTPS traffic"<br>  ]<br>}</pre> | no |
| <a name="input_alb_security_group_tags"></a> [alb_security_group_tags](#input_alb_security_group_tags) | Tags for the ALB security group | `map(string)` | <pre>{<br>  "Environment": "project_intely",<br>  "Terraform": "true"<br>}</pre> | no |
| <a name="input_autoscaling_egress_rules"></a> [autoscaling_egress_rules](#input_autoscaling_egress_rules) | Egress rules for the autoscaling security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 0,<br>    "protocol": "tcp",<br>    "to_port": 65535<br>  }<br>]</pre> | no |
| <a name="input_autoscaling_health_check_grace_period"></a> [autoscaling_health_check_grace_period](#input_autoscaling_health_check_grace_period) | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| <a name="input_autoscaling_health_check_type"></a> [autoscaling_health_check_type](#input_autoscaling_health_check_type) | Type of health check to perform | `string` | `"EC2"` | no |
| <a name="input_autoscaling_ingress_cidr_blocks"></a> [autoscaling_ingress_cidr_blocks](#input_autoscaling_ingress_cidr_blocks) | Ingress CIDR blocks for the autoscaling security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_autoscaling_ingress_rules"></a> [autoscaling_ingress_rules](#input_autoscaling_ingress_rules) | Ingress rules for the autoscaling security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 0,<br>    "protocol": "tcp",<br>    "to_port": 65535<br>  }<br>]</pre> | no |
| <a name="input_autoscaling_user_data"></a> [autoscaling_user_data](#input_autoscaling_user_data) | User data script to run on instance launch | `string` | `""` | no |
| <a name="input_create_attachment"></a> [create_attachment](#input_create_attachment) | Whether to create a target group attachment | `bool` | `false` | no |
| <a name="input_health_check_healthy_threshold"></a> [health_check_healthy_threshold](#input_health_check_healthy_threshold) | The number of successful checks before considering the target healthy | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health_check_interval](#input_health_check_interval) | The interval for the health check | `number` | `5` | no |
| <a name="input_health_check_matcher"></a> [health_check_matcher](#input_health_check_matcher) | The matcher for the health check | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health_check_path](#input_health_check_path) | The path for the health check | `string` | `"/"` | no |
| <a name="input_health_check_protocol"></a> [health_check_protocol](#input_health_check_protocol) | The protocol for the health check | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health_check_timeout](#input_health_check_timeout) | The timeout for the health check | `number` | `3` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health_check_unhealthy_threshold](#input_health_check_unhealthy_threshold) | The number of failed checks before considering the target unhealthy | `number` | `5` | no |
| <a name="input_instance_tag_name"></a> [instance_tag_name](#input_instance_tag_name) | The name tag for the instances | `string` | `"project_intely"` | no |
| <a name="input_launch_template_image_id"></a> [launch_template_image_id](#input_launch_template_image_id) | The AMI ID for the launch template | `string` | `"ami-0c0e147c706360bd7"` | no |
| <a name="input_launch_template_instance_type"></a> [launch_template_instance_type](#input_launch_template_instance_type) | The instance type for the launch template | `string` | `"t3.micro"` | no |
| <a name="input_launch_template_name_prefix"></a> [launch_template_name_prefix](#input_launch_template_name_prefix) | The prefix for the launch template name | `string` | `"my-template"` | no |
| <a name="input_launch_template_tags"></a> [launch_template_tags](#input_launch_template_tags) | Tags to apply to the launch template | `map(string)` | <pre>{<br>  "Environment": "project_intely",<br>  "Name": "project_intely-web-server",<br>  "Terraform": "true"<br>}</pre> | no |
| <a name="input_launch_template_user_data_file"></a> [launch_template_user_data_file](#input_launch_template_user_data_file) | The path to the user data script file | `string` | `"user-data.sh"` | no |
| <a name="input_launch_template_volume_size"></a> [launch_template_volume_size](#input_launch_template_volume_size) | The size of the root EBS volume (in GB) | `number` | `1` | no |
| <a name="input_listener_port"></a> [listener_port](#input_listener_port) | The port for the listener | `number` | `80` | no |
| <a name="input_listener_protocol"></a> [listener_protocol](#input_listener_protocol) | The protocol for the listener | `string` | `"HTTP"` | no |
| <a name="input_rds_master_username"></a> [rds_master_username](#input_rds_master_username) | The master username for the RDS Aurora cluster | `string` | `"admin"` | no |
| <a name="input_rds_tags"></a> [rds_tags](#input_rds_tags) | A map of tags to apply to the RDS Aurora resources | `map(string)` | `{}` | no |
| <a name="input_security_group_egress_rules"></a> [security_group_egress_rules](#input_security_group_egress_rules) | Egress rules for the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>    description = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all outbound traffic",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_security_group_ingress_rules"></a> [security_group_ingress_rules](#input_security_group_ingress_rules) | Ingress rules for the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>    description = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow HTTP from anywhere",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow HTTPS from anywhere",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>]</pre> | no |
| <a name="input_security_group_tags"></a> [security_group_tags](#input_security_group_tags) | Tags for the security group | `map(string)` | <pre>{<br>  "Environment": "project_intely"<br>}</pre> | no |
| <a name="input_target_group_name"></a> [target_group_name](#input_target_group_name) | target group name | `string` | `"project-intely-tg"` | no |
| <a name="input_target_group_port"></a> [target_group_port](#input_target_group_port) | The port for the target group | `number` | `80` | no |
| <a name="input_vpc_azs"></a> [vpc_azs](#input_vpc_azs) | Availability Zones for the VPC | `list(string)` | <pre>[<br>  "eu-north-1a",<br>  "eu-north-1b",<br>  "eu-north-1c"<br>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_enable_nat_gateway"></a> [vpc_enable_nat_gateway](#input_vpc_enable_nat_gateway) | Enable NAT Gateway for the VPC | `bool` | `true` | no |
| <a name="input_vpc_name"></a> [vpc_name](#input_vpc_name) | Name of the VPC | `string` | `"my-vpc"` | no |
| <a name="input_vpc_private_subnets"></a> [vpc_private_subnets](#input_vpc_private_subnets) | Private subnet CIDR blocks | `list(string)` | <pre>[<br>  "10.0.10.0/24",<br>  "10.0.20.0/24",<br>  "10.0.30.0/24"<br>]</pre> | no |
| <a name="input_vpc_public_subnets"></a> [vpc_public_subnets](#input_vpc_public_subnets) | Public subnet CIDR blocks | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_vpc_tags"></a> [vpc_tags](#input_vpc_tags) | Tags to apply to the VPC resources | `map(string)` | <pre>{<br>  "Environment": "project_intely",<br>  "Terraform": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb_dns_name](#output_alb_dns_name) | The DNS name of the Application Load Balancer |
| <a name="output_launch_template_id"></a> [launch_template_id](#output_launch_template_id) | n/a |
| <a name="output_launch_template_version"></a> [launch_template_version](#output_launch_template_version) | n/a |
<!-- END_TF_DOCS -->