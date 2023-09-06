output "address" {
  value       = aws_db_instance.testdb.address
  description = "Connection endpoint"
}

output "port" {
  value       = aws_db_instance.testdb.port
  description = "Connection port"
}