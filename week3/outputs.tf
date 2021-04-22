output "db_address" {
  value = aws_db_instance.rds_postgres.endpoint
}

output "bastion_address" {
  value = aws_instance.db_bastion.public_dns
}