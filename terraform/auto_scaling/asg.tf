data "terraform_remote_state" "alb_outputs" {
  backend = "local"

  config = {
    path = "../elb/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking_outputs" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "ecom_app_asg" {
  name              = "${aws_launch_configuration.ecom_app_web_lconfig.name}-asg"
  min_size          = 1
  desired_capacity  = 1
  max_size          = 2
  health_check_type = "ELB"
  target_group_arns      = [data.terraform_remote_state.alb_outputs.outputs.alb_target_grp_arn]

  launch_configuration = aws_launch_configuration.ecom_app_web_lconfig.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = [
    data.terraform_remote_state.networking_outputs.outputs.subnet_id_1,
    data.terraform_remote_state.networking_outputs.outputs.subnet_id_2
  ]

  # Requires to redeploy without an outage
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "ecom_app_web"
    propagate_at_launch = true
  }
}
