# Create DynamoDB Table
resource "aws_dynamodb_table" "tf_products_table" {
  name = "tf-products-table"
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
