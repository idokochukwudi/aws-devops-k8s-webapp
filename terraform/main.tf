module "networking" {
  source                  = "./modules/networking"
  vpc_cidr                = var.vpc_cidr
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  private_1_cidr       = var.private_1_cidr
  private_2_cidr       = var.private_2_cidr
  azs                     = var.azs
  allowed_app_subnet_cidr = var.allowed_app_subnet_cidr
}


module "ec2" {
  source         = "./modules/ec2"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  private_subnet_id  = module.networking.private_subnet_ids[0]
  key_name       = var.key_name
  vpc_id            = module.networking.vpc_id
  allowed_ssh_cidr  = var.allowed_ssh_cidr
  bastion_sg_id     = module.bastion.bastion_sg_id
}

module "rds" {
  source = "./modules/rds"

  subnet_ids         = module.networking.private_subnet_ids
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  db_username         = var.db_username
  db_password         = var.db_password
  engine_version     = var.engine_version
  ec2_security_group_id = module.ec2.ec2_sg_id
  vpc_id = module.networking.vpc_id
  db_sg_id = module.ec2.ec2_sg_id
}

module "bastion" {
  source                = "./modules/bastion"
  bastion_ami_id        = var.bastion_ami_id
  bastion_instance_type = var.bastion_instance_type
  subnet_id     = module.networking.subnet_ids[1]
  vpc_id                = module.networking.vpc_id
  key_name              = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
}
