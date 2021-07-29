output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.demo.*.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.demo.*.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.demo.*.username
  sensitive   = true
}

// output "rds_replica_connection_parameters" {
//   description = "RDS replica instance connection parameters"
//   value       = "-h ${aws_db_instance.demo_replica.address} -p ${aws_db_instance.demo_replica.port} -U ${aws_db_instance.demo_replica.username} postgres"
// }