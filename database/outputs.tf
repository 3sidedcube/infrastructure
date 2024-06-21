output "username" {
  description = "Database username"
  value       = aws_rds_cluster.main.master_username
}
output "password" {
  description = "Database password"
  value       = random_password.main.result
  sensitive   = true
}

output "endpoint" {
  value = aws_rds_cluster.main.endpoint
}

output "identifier" {
  value = aws_rds_cluster.main.cluster_identifier
}

output "port" {
  value = aws_rds_cluster.main.port
}

output "database_name" {
  value = aws_rds_cluster.main.database_name
}

output "security_group_id" {
  value = aws_security_group.main.id
}
