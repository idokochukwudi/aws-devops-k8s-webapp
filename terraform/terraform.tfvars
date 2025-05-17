# ========================
# VPC and Networking Setup
# ========================

vpc_cidr              = "10.0.0.0/16"
public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"
private_1_cidr = "10.0.3.0/24"
private_2_cidr = "10.0.4.0/24"
allowed_app_subnet_cidr = "10.0.3.0/24"
# List of availability zones to distribute resources across
azs                   = ["us-east-1a", "us-east-1b"]


# =====================
# EC2 Instance Settings
# =====================

ami_id                = "ami-0deb99630c51db514"
instance_type         = "t2.micro"
key_name              = "cloudit-key"


# ============================
# RDS (PostgreSQL) DB Settings
# ============================
allocated_storage = 20
engine_version = "13.12"
instance_class = "db.t3.micro"
db_name = "mydb"

# Subnet group name for placing the RDS instance within selected subnets
db_subnet_group       = "my-db-subnet-group"
allowed_ssh_cidr = "0.0.0.0/0"  # or more secure, e.g., "203.0.113.0/24"