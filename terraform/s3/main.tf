
resource "aws_s3_bucket" "ecom_app_products_s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_object" "ecom_app_s3_bucket_objects" {
  for_each = fileset(var.source_directory, "*")
  bucket   = aws_s3_bucket.ecom_app_products_s3_bucket.id
  key      = each.value
  source   = "${var.source_directory}/${each.value}"
}

