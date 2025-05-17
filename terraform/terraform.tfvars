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

ami_id                = "ami-09382da2dc76dcf9f"
instance_type         = "t2.micro"
key_name              = "cloudit-key"


# ============================
# RDS (PostgreSQL) DB Settings
# ============================
allocated_storage = 20
engine_version = "13.21"
instance_class = "db.t3.micro"
db_name = "mydb"

# Subnet group name for placing the RDS instance within selected subnets
db_subnet_group       = "my-db-subnet-group"
allowed_ssh_cidr  = "10.0.1.0/24"

# bastion
bastion_ami_id        = "ami-0c02fb55956c7d316" # Amazon Linux 2 (official)
bastion_instance_type = "t2.micro"
my_ip_cidr            = "192.168.0.0/24" # my IP address
