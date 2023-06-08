# Create Auto Scaling Group
resource "aws_autoscaling_group" "ecom_app_asg" {
  name              = "${aws_launch_configuration.ecom_app_web_lconfig}-asg"
  min_size          = 1
  desired_capacity  = 1
  max_size          = 2
  health_check_type = "ELB"
  load_balancers = [
    "${aws_elb.ecom_app_web_elb.id}"
  ]
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
    "${aws_subnet.ecom_app_subnet_1}",
    "${aws_subnet.ecom_app_subnet_2}"
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
