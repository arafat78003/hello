module "vpc" {
  source       = "./module/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  availability = var.availability
  privatesubnet_cidr = var.privatesubnet_cidr

}

module "sg" {
    source = "./module/sg"
    vpc_id = module.vpc.vpc_id
  
}

module "ec2" {
    source = "./module/ec2"
    public_sg_id = module.sg.public_sg_id
    private_sg_id = module.sg.private_sg_id
    public_subnet = module.vpc.public_subnet_id
    private_subnet = module.vpc.private_subnet_id
    availability = var.availability
}

module "alb" {
    source = "./module/alb"
    sg_id = module.sg.public_sg_id
    alb_subnet = module.vpc.public_subnet_id
    myvpc = module.vpc.vpc_id
    instances = module.ec2.public_instance
    private_instance = module.ec2.private_instance


  
}