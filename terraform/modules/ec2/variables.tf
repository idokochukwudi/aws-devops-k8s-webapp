# variables.tf
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "key_name" {}
variable "vpc_id" {}
variable "allowed_ssh_cidr" {}
variable "private_subnet_id" {}
variable "bastion_sg_id" {
  description = "Security Group ID of the Bastion Host that is allowed SSH access"
}