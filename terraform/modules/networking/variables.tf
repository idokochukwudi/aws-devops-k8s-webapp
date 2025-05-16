# variables.tf
variable "vpc_cidr" {}
variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}
variable "private_1_cidr" {}
variable "private_2_cidr" {}
variable "azs" {
  type = list(string)
}
variable "allowed_app_subnet_cidr" {
  description = "CIDR block allowed to connect to RDS (e.g., application subnet)"
}

