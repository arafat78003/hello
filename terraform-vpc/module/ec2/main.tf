resource "aws_instance" "webserver" {
    count = length(var.ec2_name)
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name                    = "vishal"
    vpc_security_group_ids = [var.public_sg_id]
    associate_public_ip_address = true
    subnet_id = var.public_subnet[count.index]
    availability_zone = var.availability[count.index]
    tags = {
        Name = var.ec2_name[count.index]
      
    }
     provisioner "file" {
    source      = "./vishal.pem"
    destination = "/home/ec2-user/vishal.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = "${file("./vishal.pem")}"

    }
  }
 
}

resource "aws_instance" "dbserver" {
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name                    = "vishal"
    vpc_security_group_ids = [var.private_sg_id]
    subnet_id = var.private_subnet
    availability_zone = var.availability[0]
    tags = {
      Name = "dbserver"
    }

}