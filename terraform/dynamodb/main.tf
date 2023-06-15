# Create DynamoDB Products Table
resource "aws_dynamodb_table" "ecom_app_products_table" {
  name = var.ecom_app_products_table
  billing_mode = "PROVISIONED"
  read_capacity = "30"
  write_capacity = "30"
  attribute {
    name = "productId"
    type = "S"
  }
  hash_key = "productId"
  ttl {
    enabled = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}

# Create DynamoDB Users Table
resource "aws_dynamodb_table" "ecom_app_users_table" {
  name = var.ecom_app_users_table
  billing_mode = "PROVISIONED"
  read_capacity = "30"
  write_capacity = "30"
  attribute {
    name = "userId"
    type = "S"
  }
  hash_key = "userId"
  ttl {
    enabled = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}

# Create DynamoDB Orders Table
resource "aws_dynamodb_table" "ecom_app_orders_table" {
  name = var.ecom_app_orders_table
  billing_mode = "PROVISIONED"
  read_capacity = "30"
  write_capacity = "30"
  attribute {
    name = "ordersId"
    type = "S"
  }
  hash_key = "ordersId"
  ttl {
    enabled = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}