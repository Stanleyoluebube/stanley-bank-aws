output "rds_endpoint" {
  description = "RDS endpoint (host:port)"
  value       = aws_db_instance.stanley_bank_db.endpoint
  sensitive   = true
}

output "rds_host" {
  description = "RDS host (hostname only)"
  value       = aws_db_instance.stanley_bank_db.address
}
