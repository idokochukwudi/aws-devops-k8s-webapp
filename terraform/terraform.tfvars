vpc_cidr             = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"
azs                  = ["us-east-1a", "us-east-1b"]

ami_id         = "ami-06bcf6ba92b21f952"
instance_type  = "t2.micro"
key_name       = "cloudit-key"