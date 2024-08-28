variable "public_sg_id" {
    type = string

  
}

variable "private_sg_id" {
    type = string

  
}
variable "public_subnet" {
    type = list(string)
  
}
variable "private_subnet" {
    type = string
  
}

variable "ec2_name" {
    type = list(string)
    default = [ "webserver1", "webserver2" ]
  
}

variable "availability" {
    type = list(string)
  
}