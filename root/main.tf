#call the VPC child module

module "vpc" {
  source = "../modules/vpc"

  cidr_vpc        = var.cidr_block
  project_name    = var.project_name
  pub_sub_1a_cidr = var.pub_sub_1a_cidr_input
  pub_sub_2b_cidr = var.pub_sub_2b_cidr_input
  pri_sub_3a_cidr = var.pri_sub_3a_cidr_input
  pri_sub_4b_cidr = var.pri_sub_4b_cidr_input
  pri_sub_5a_cidr = var.pri_sub_5a_cidr_input
  pri_sub_6b_cidr = var.pri_sub_6b_cidr_input
}

#call the NAT child module

module "Nat" {
  source = "../modules/Nat"

  project_name  = module.vpc.project_name
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
  igw_id        = module.vpc.igw_id
  vpc_id        = module.vpc.vpc_id
}


#call the Security Group child module

module "security-group" {
  source = "../modules/security-group"

  project_name = module.vpc.project_name
  vpc_id       = module.vpc.vpc_id
}


# Call the KEY module for creating Key for instances
module "key" {
  source = "../modules/key"
}

# Call the ALB module 
module "alb" {
  source = "../modules/alb"

  project_name  = module.vpc.project_name
  alb_sg_id     = module.security-group.alb_sg_id
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  vpc_id        = module.vpc.vpc_id
}

# Call the ASG module
module "asg" {
  source = "../modules/asg"

  project_name  = module.vpc.project_name
  key_name      = module.key.key_name
  client_sg_id  = module.security-group.client_sg_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  tg_arn        = module.alb.tg_arn
}

# Call the RDSmodule to create RDS instance
module "rds" {
  source = "../modules/rds"


  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
  db_username   = var.db_username_input
  db_password   = var.db_password_input
  db_sg_id      = module.security-group.db_sg_id
  project_name  = module.vpc.project_name

}


