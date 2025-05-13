# outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
