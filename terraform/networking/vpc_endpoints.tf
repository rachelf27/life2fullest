// terraform/networking/vpc_endpoints.tf

# Create EC2 VPC Interface Endpoint
resource "aws_vpc_endpoint" "vpc-ec2-endpoint" {
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : "*",
        "Effect" : "Allow",
        "Principal" : "*",
        "Resource" : "*"
      }
    ]
  })
  security_group_ids = [
    aws_security_group.eks_cluster_security_group.id,
    aws_security_group.eks_all_nodes_security_group.id
  ]
  service_name = "com.amazonaws.us-east-1.ec2"
  subnet_ids = [
    aws_subnet.ecom_app_subnet_1.id,
    aws_subnet.ecom_app_subnet_2.id
  ]
  tags = {
    Name = "vpc-ec2-endpoint"
  }
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.ecom_app_vpc.id
}

# Create ECR API VPC Interface Endpoint
resource "aws_vpc_endpoint" "vpc-ecr-api-endpoint" {
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : "*",
        "Effect" : "Allow",
        "Principal" : "*",
        "Resource" : "*"
      }
    ]
  })
  security_group_ids = [
    aws_security_group.eks_cluster_security_group.id,
    aws_security_group.eks_all_nodes_security_group.id
  ]
  service_name = "com.amazonaws.us-east-1.ecr.api"
  subnet_ids = [
    aws_subnet.ecom_app_subnet_1.id,
    aws_subnet.ecom_app_subnet_2.id
  ]
  tags = {
    Name = "vpc-ecr-api-endpoint"
  }
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.ecom_app_vpc.id
}

# Create ECR DKR VPC Interface Endpoint
resource "aws_vpc_endpoint" "vpc-ecr-dkr-endpoint" {
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : "*",
        "Effect" : "Allow",
        "Principal" : "*",
        "Resource" : "*"
      }
    ]
  })
  security_group_ids = [
    aws_security_group.eks_cluster_security_group.id,
    aws_security_group.eks_all_nodes_security_group.id
  ]
  service_name = "com.amazonaws.us-east-1.ecr.dkr"
  subnet_ids = [
    aws_subnet.ecom_app_subnet_1.id,
    aws_subnet.ecom_app_subnet_2.id
  ]
  tags = {
    Name = "vpc-ecr-dkr-endpoint"
  }
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.ecom_app_vpc.id
}

# Create STS VPC Interface Endpoint
resource "aws_vpc_endpoint" "vpc-sts-endpoint" {
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : "*",
        "Effect" : "Allow",
        "Principal" : "*",
        "Resource" : "*"
      }
    ]
  })
  security_group_ids = [
    aws_security_group.eks_cluster_security_group.id,
    aws_security_group.eks_all_nodes_security_group.id
  ]
  service_name = "com.amazonaws.us-east-1.sts"
  subnet_ids = [
    aws_subnet.ecom_app_subnet_1.id,
    aws_subnet.ecom_app_subnet_2.id
  ]
  tags = {
    Name = "vpc-sts-endpoint"
  }
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.ecom_app_vpc.id
}

# Create S3 VPC Gateway Endpoint
resource "aws_vpc_endpoint" "vpc-s3-endpoint" {
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
  route_table_ids = [
    aws_route_table.ecom_app_route.id,
  ]
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    Name = "vpc-s3-endpoint"
  }
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.ecom_app_vpc.id
}

resource "aws_vpc_endpoint_route_table_association" "example" {
  route_table_id  = aws_route_table.ecom_app_route.id
  vpc_endpoint_id = aws_vpc_endpoint.vpc-s3-endpoint.id
}

# Create DynamoDB VPC Gateway Endpoint
resource "aws_vpc_endpoint" "vpc_dynamodb_endpoint" {
  vpc_id       = aws_vpc.ecom_app_vpc.id
  service_name = "com.amazonaws.us-east-1.dynamodb"

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
  route_table_ids = [
    aws_route_table.ecom_app_route.id,
  ]

  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "vpc-dynamodb-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  route_table_id  = aws_route_table.ecom_app_route.id
  vpc_endpoint_id = aws_vpc_endpoint.vpc_dynamodb_endpoint.id
}
