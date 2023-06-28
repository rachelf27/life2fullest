// terraform/networking/key_pair.tf

resource "aws_key_pair" "ecom_app_key_pair" {
  key_name   = "ecom_app_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ecom_app_private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "ecom_app_key"
}

output "key_name" {
  value = aws_key_pair.ecom_app_key_pair.key_name
}
