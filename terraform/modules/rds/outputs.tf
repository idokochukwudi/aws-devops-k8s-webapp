output "rds_endpoint" {
  value       = aws_db_instance.postgres.endpoint
  description = "The endpoint of the RDS instance"
}

output "rds_id" {
  value       = aws_db_instance.postgres.id
  description = "The RDS instance identifier"
}

output "rds_sg_id" {
value         = aws_security_group.rds_sg.id
description   = "The RDS security group identifier"
}