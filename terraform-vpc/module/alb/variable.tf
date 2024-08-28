variable "sg_id" {
    type = string
  
}
variable "alb_subnet" {
    type = list(string)
  
}
variable "myvpc" {
    type = string
  
}
variable "instances" {
    type = list(string)
}
variable "private_instance" {
    type = string
  
}