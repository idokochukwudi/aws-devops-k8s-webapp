output "bastion_sg_id" {
description = "Security Group ID for the Bastion Host"
value       = aws_security_group.bastion_sg.id
}

output "subnet_id" {
  description = "Security Group ID for the Bastion Host"
  value       = aws_security_group.bastion_sg.id
}