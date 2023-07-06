// terraform/cloudwatch.tf

variable "sns_topic_arn" {
  description = "SNS Topic ARN for AWS CPU Alarm"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
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
  alarm_actions       = [var.sns_topic_arn]
  dimensions = {
    ClusterName = var.cluster_name
    Namespace   = "EKS Cloudwatch Namespace"
  }
}
