// terraform/iam_role_policy.tf

# Get the S3 Bucket ARN from .tfstate to use in the EC2 Policy to access S3 Bucket
variable "bucket_arn" {
  description = "S3 Bucket ARN"
  type        = string
}

# Create IAM Role for EC2
resource "aws_iam_role" "ecom_app_ec2_role" {
  name               = "ecom-app-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

# Create IAM Role for EKS Cluster
resource "aws_iam_role" "ecom_eks_cluster_role" {
  name               = "ecom-eks-cluster-role"
  assume_role_policy = <<EOF
{
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
}
EOF
  tags = {
    Name = "ecom-eks-cluster-role"
  }
}

# Create IAM Role for EKS Nodes
resource "aws_iam_role" "eks_node_role" {
  name               = "ecom-eks-node-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
  tags = {
    Name = "ecom-eks-node-role"
  }
}


# Create EC2 Policy to list and download objects in S3 bucket
resource "aws_iam_policy" "ecom_app_ec2_policy" {
  name   = "ecom-app-ec2-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${var.bucket_arn}"
      ]
    }
  ]
}
EOF
}

# Create DynamoDB Policy for EC2
resource "aws_iam_policy" "ecom_app_dynamodb_policy" {
  name   = "ecom-app-dynamodb-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach IAM EC2 Role to DynamoDB Policy
resource "aws_iam_policy_attachment" "ecom_app_dynamodb_policy_role_attachment" {
  name       = "ecom-app-dynamodb-policy-role-attachment"
  roles      = [aws_iam_role.ecom_app_ec2_role.name]
  policy_arn = aws_iam_policy.ecom_app_dynamodb_policy.arn
}

# Attach IAM EC2 Role to Policy
resource "aws_iam_policy_attachment" "ecom_app_ec2_policy_role_attachment" {
  name       = "ecom-app-ec2-policy-role-attachment"
  roles      = [aws_iam_role.ecom_app_ec2_role.name]
  policy_arn = aws_iam_policy.ecom_app_ec2_policy.arn
}

# Attach IAM EKS Cluster Role to Cluster Policy
resource "aws_iam_role_policy_attachment" "ecom_eks_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.ecom_eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Attach IAM EKS Node Role to EKS Worker Node Policy
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach IAM EKS Node Role to EKS CNI Policy
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach IAM EKS Node Role to EKS Conatiner Registry Policy
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
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
