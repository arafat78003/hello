output "public_sg_id" {
    value = aws_security_group.publicsubnetsg.id
  
}

output "private_sg_id" {
    value = aws_security_group.privatesubnetsg.id
  
}