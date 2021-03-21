output "db_sg" {
  value = aws_security_group.db.id
}

output "app_sg" {
  value = aws_security_group.app.id
}

output "web_sg" {
  value = aws_security_group.web.id
}