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

resource "aws_iam_role" "eks_node_role" {
  name               = "eks-node-role"
  assume_role_policy = <<EOF
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          }
        }
      ]
    }
  EOF
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

# Attach EC2 IAM Role to Policy
resource "aws_iam_policy_attachment" "ecom_app_ec2_policy_role_attachment" {
  name       = "ecom-app-ec2-policy-role-attachment"
  roles      = [aws_iam_role.ecom_app_ec2_role.name]
  policy_arn = aws_iam_policy.ecom_app_ec2_policy.arn
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

output "iam_role_arn" {
  description = "The IAM role ARN for EKS worker Nodes"
  value       = aws_iam_role.eks_node_role.arn
}

output "iam_role_name" {
  description = "The IAM role name for EKS worker Nodes"
  value       = aws_iam_role.eks_node_role.name
}
