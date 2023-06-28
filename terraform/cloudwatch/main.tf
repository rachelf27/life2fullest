// terraform/cloudwatch.tf

variable "sns_topic" {
  description = "SNS Topic for AWS CPU Alarm"
  type        = string
}

variable "cluster_name" {
  description = "Name of teh EKS Cluster"
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
  alarm_actions       = [var.sns_topic.arn]
  dimensions = {
    ClusterName = var.cluster_name
    Namespace   = "your-app-namespace"
  }
}
