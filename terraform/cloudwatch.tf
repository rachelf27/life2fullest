// terraform/cloudwatch.tf

variable "instance_id" {
  description = "Instance Id"
  type        = string
}

resource "aws_cloudwatch_metric_alarm" "pod_cpu_usage_high" {
  alarm_name          = "pod-cpu-usage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "pod_cpu_usage"
  namespace           = "ContainerInsights"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_actions       = [aws_sns_topic.cpu_alarm.arn]
  dimensions = {
    ClusterName = module.eks.cluster_name
    Namespace = "your-app-namespace"
  }
}