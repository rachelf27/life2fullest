// terraform/dynamodb/main.tf

variable "ecom_app_products_table" {
  type    = string
  default = "ecom-app-products-table"
}

variable "ecom_app_users_table" {
  type    = string
  default = "ecom-app-users-table"
}

variable "ecom_app_orders_table" {
  type    = string
  default = "ecom-app-orders-table"
}

# Create the DynamoDB Products Table
resource "aws_dynamodb_table" "ecom_app_products_table" {
  name           = var.ecom_app_products_table
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "productId"
    type = "S"
  }
  hash_key = "productId"
  ttl {
    enabled        = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}

# Create the DynamoDB Users Table
resource "aws_dynamodb_table" "ecom_app_users_table" {
  name           = var.ecom_app_users_table
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "userId"
    type = "S"
  }
  hash_key = "userId"
  ttl {
    enabled        = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}

# Create the DynamoDB Orders Table
resource "aws_dynamodb_table" "ecom_app_orders_table" {
  name           = var.ecom_app_orders_table
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "ordersId"
    type = "S"
  }
  hash_key = "ordersId"
  ttl {
    enabled        = true
    attribute_name = "expiryPeriod"
  }

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
}

// Output Product, Users, and Orders Table IDs
output "product_table_id" {
  description = "DynamoDB Product Table ID"
  value       = aws_dynamodb_table.ecom_app_products_table.id
}

output "users_table_id" {
  description = "DynamoDB Users Table ID"
  value       = aws_dynamodb_table.ecom_app_users_table.id
}

output "orders_table_id" {
  description = "DynamoDB Orders Table ID"
  value       = aws_dynamodb_table.ecom_app_orders_table.id
}
