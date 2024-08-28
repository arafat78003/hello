variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}

variable "availability" {
  type = list(string)

}
variable "privatesubnet_cidr" {
    type = string
  
}