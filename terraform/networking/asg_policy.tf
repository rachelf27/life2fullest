# Create Auto Scaling Group Policy for Scaling Up
resource "aws_autoscaling_policy" "ecom_app_asg_policy_up" {
  name                   = "ecom_web_asg_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecom_app_asg.name
}

# Create CloudWatch Metric Alarm for High Threshold Alarm
resource "aws_cloudwatch_metric_alarm" "ecom_app_high_cpu_alarm" {
  alarm_name          = "ecom_app_high_cpu_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.ecom_app_asg.name}"
  }
  alarm_description = "This CloudWatch Alarm metric is to monitor for High CPU Utilization"
  alarm_actions     = ["${aws_autoscaling_policy.ecom_app_asg_policy_up.arn}"]
}

# Create Auto Scaling Group Policy for Scaling Down
resource "aws_autoscaling_policy" "ecom_app_asg_policy_down" {
  name                   = "ecom_web_asg_policy_down"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecom_app_asg.name
}
# Create CloudWatch Metric Alarm for Low Threshold Alarm
resource "aws_cloudwatch_metric_alarm" "ecom_app_low_cpu_alarm" {
  alarm_name          = "ecom_app_low_cpu_alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.ecom_app_asg.name}"
  }
  alarm_description = "This CloudWatch Alarm metric is to monitor for Low CPU Utilization"
  alarm_actions     = ["${aws_autoscaling_policy.ecom_app_asg_policy_down.arn}"]
}
