variable "AWS_ACCESS_KEY" {
  description = "AWS access key"
  default     = var.AWS_ACCESS_KEY != "" ? var.AWS_ACCESS_KEY : null
}

variable "AWS_SECRET_KEY" {
  description = "AWS secret key"
    default     = var.AWS_SECRET_KEY != "" ? var.AWS_SECRET_KEY : null
}
