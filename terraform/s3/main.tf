// terraform/s3/main.tf

variable "bucket_name" {
  type    = string
  default = "ecom-app-products-s3-bucket"
}

variable "source_directory" {
  type    = string
  default = "../../e_com_products"
}

// Create an S3 Bucket to store product images
resource "aws_s3_bucket" "ecom_app_products_s3_bucket" {
  bucket = var.bucket_name
}

// Upload all image files from the source directory to the S3 Bucket
resource "aws_s3_bucket_object" "ecom_app_s3_bucket_objects" {
  for_each = fileset(var.source_directory, "*")
  bucket = aws_s3_bucket.ecom_app_products_s3_bucket.id
  key    = each.value
  source = "${var.source_directory}/${each.value}"
}

// Output Bucket ID and ARN
output "bucket_id" {
  description = "S3 Bucket ID"
  value       = aws_s3_bucket.ecom_app_products_s3_bucket.id
}

output "bucket_arn" {
  description = "S3 Bucket ARN"
  value       = aws_s3_bucket.ecom_app_products_s3_bucket.arn
}

