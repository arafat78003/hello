output "public_instance" {
    value = aws_instance.webserver.*.id
  
}
output "private_instance" {
  value = aws_instance.dbserver.id
}