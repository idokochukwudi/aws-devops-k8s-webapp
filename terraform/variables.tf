# CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# CIDR block for the first public subnet
variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

# CIDR block for the second public subnet
variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

# Availability Zones to use for subnets
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

# ID of the custom AMI built with Packer
variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

# EC2 instance type (e.g., t2.micro)
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# Name of the existing key pair to use for SSH
variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

# RDS
variable "allocated_storage" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_subnet_group" {}

variable "allowed_app_subnet_cidr" {
  description = "CIDR block allowed to access RDS and other internal services"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into EC2"
  type        = string
}

variable "private_1_cidr" {
  description = "CIDR block for private subnet 1"
}

variable "private_2_cidr" {
  description = "CIDR block for private subnet 2"
}
