variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs (private preferred) for RDS"
}

variable "db_sg_id" {
  type        = string
  description = "Security group ID that allows access to the RDS instance"
}

variable "instance_class" {
  type        = string
  description = "RDS instance type (e.g., db.t3.micro)"
}

variable "allocated_storage" {
  type        = number
  description = "Storage in GB for the RDS database"
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine"
  default     = null
}

variable "ec2_security_group_id" {
  description = "The Security Group ID for EC2 instances allowed to access RDS"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

