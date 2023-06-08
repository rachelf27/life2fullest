# # Define Public Key for managing SSH
# variable "public_key" {
#   default = "ecom_app_key_pair.pub"
# }

# # Define Private Key for managing SSH
# variable "private_key" {
#   default = "../../../../../Downloads/ecom_app_key_pair.pem"
# }

# Define CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Define CIDR Block for Subnet 1
variable "subnet_1_cidr" {
  default = "10.0.1.0/24"
}

# Define CIDR Block for Subnet 2
variable "subnet_2_cidr" {
  default = "10.0.2.0/24"
}

# Define Key Pair name
variable "key_name" {
  description = "The name of the Key Pair"
  default     = "ecom_app_key_pair"
}
