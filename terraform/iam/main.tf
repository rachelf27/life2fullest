// terraform/iam_role_policy.tf

# Get the S3 Bucket ARN from .tfstate to use in the EC2 Policy to access S3 Bucket
variable "bucket_arn" {
  description = "S3 Bucket ARN"
  type        = string
}


# Create IAM Role for EKS Cluster
resource "aws_iam_role" "ecom_eks_cluster_role" {
  name               = "ecom-eks-cluster-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })
  tags = {
    Name = "ecom-eks-cluster-role"
  }
}

# Create IAM Role for EKS Node
resource "aws_iam_role" "eks_node_role" {
  name = "ecom-eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create S3 Policy
resource "aws_iam_policy" "ecom_app_s3_policy" {
  name = "ecom-app-s3-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "s3:Put*",
        "s3:Get*",
        "s3:List*",
        "s3:Delete*"
      ],
      Effect   = "Allow",
      Resource = ["${var.bucket_arn}/*", "${var.bucket_arn}", "*"]
    }]
  })
}

# Create DynamoDB Policy for EC2
resource "aws_iam_policy" "ecom_app_dynamodb_policy" {
  name   = "ecom-app-dynamodb-policy"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
   }]
  })
}

# Create CloudWatch Policy to push logs to CloudWatch
resource "aws_iam_policy" "eks_cloudwatch_logs_policy" {
  name   = "ecom-app-cloudwatch-logs-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Effect   = "Allow",
        Resource = ["*"]
      }
    ]
  })
}

# Attach Custom Policies to EKS Node Role
resource "aws_iam_role_policy_attachment" "eks_node_custom_policies" {
  for_each = {
    s3       = aws_iam_policy.ecom_app_s3_policy.arn,
    dynamodb = aws_iam_policy.ecom_app_dynamodb_policy.arn
  }
  policy_arn = each.value
  role       = aws_iam_role.eks_node_role.name
}

# Attach AWS Managed Policies using Data Blocks
data "aws_iam_policy" "aws_managed_policies" {
  for_each = toset([
    "AmazonEKSClusterPolicy",
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ])

  arn = "arn:aws:iam::aws:policy/${each.key}"
}

resource "aws_iam_role_policy_attachment" "aws_managed_policies" {
  for_each   = data.aws_iam_policy.aws_managed_policies
  policy_arn = each.value.arn

  # Conditional assignment to attach the policy to the right role
  role = each.key == "AmazonEKSClusterPolicy" ? aws_iam_role.ecom_eks_cluster_role.name : aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cloudwatch_logs_attachment" {
  policy_arn = aws_iam_policy.eks_cloudwatch_logs_policy.arn
  role       = aws_iam_role.eks_node_role.name
}

output "iam_eks_cluster_role_name" {
  description = "The IAM role name for EKS Cluster"
  value       = aws_iam_role.ecom_eks_cluster_role.name
}

output "iam_role_arn" {
  description = "The IAM role ARN for EKS worker Nodes"
  value       = aws_iam_role.eks_node_role.arn
}

output "iam_role_name" {
  description = "The IAM role name for EKS worker Nodes"
  value       = aws_iam_role.eks_node_role.name
}
