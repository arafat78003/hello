resource "aws_security_group" "publicsubnetsg" {
  name        = "allow_tls1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "publicsg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv41" {
  security_group_id = aws_security_group.publicsubnetsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}




resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv42" {
  security_group_id = aws_security_group.publicsubnetsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "privatesubnetsg" {
  name        = "allow_tls2"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "privatesg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv43" {
  security_group_id = aws_security_group.privatesubnetsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}




resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv44" {
  security_group_id = aws_security_group.privatesubnetsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}