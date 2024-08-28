variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}   

variable "availability" {
    type = list(string)
  
}

variable "subnet_name" {
    type = list(string)
    default = [ "publicsubnet1", "publicsubnet2" ]
  
}
variable "privatesubnet_cidr" {
    type = string
  
}