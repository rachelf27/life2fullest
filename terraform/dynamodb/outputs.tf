output "product_table_id" {
  value = aws_dynamodb_table.ecom_app_products_table.id
}

output "users_table_id" {
  value = aws_dynamodb_table.ecom_app_users_table.id
}

output "orders_table_id" {
  value = aws_dynamodb_table.ecom_app_orders_table.id
}