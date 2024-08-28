#vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "myvpc"
    }
  
}


#subnet
resource "aws_subnet" "mysubnet" {
  count  = length(var.subnet_cidr)  
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.availability[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name[count.index]
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.privatesubnet_cidr
  availability_zone = var.availability[0]
  tags = {
    Name = "privatesubnet"
  }
}




#internet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "igw"
    }
  
}
#EIP
resource "aws_eip" "myeip" {
  domain = "vpc"
  tags = {
    Name = "myeip"
  }
}


#NAT gateway
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.mysubnet[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#route
resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table" "myroute1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }
  tags = {
    Name = "privateroute"
  }
}


#route association

resource "aws_route_table_association" "a" {
    count = length(var.subnet_cidr)
    subnet_id = aws_subnet.mysubnet[count.index].id
    route_table_id = aws_route_table.myroute.id
  
}

resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.privatesubnet.id
    route_table_id = aws_route_table.myroute1.id
  
}