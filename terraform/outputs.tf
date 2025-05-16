output "vpc_id" {
  value = module.networking.vpc_id
}

output "subnet_ids" {
  value = module.networking.subnet_ids
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_id" {
  value = module.rds.rds_id
}