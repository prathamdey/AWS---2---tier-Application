variable "project_name" {
  description = "name of the project"
}

variable "aws_region" {
  description = "region we are using"
}

variable "cidr_block" {
  description = "cidr of the vpc"
}

variable "pub_sub_1a_cidr_input" {
  description = "cidr for public subnet 1"
}

variable "pub_sub_2b_cidr_input" {
  description = "cidr for public subnet 2"
}

variable "pri_sub_3a_cidr_input" {}
variable "pri_sub_4b_cidr_input" {}
variable "pri_sub_5a_cidr_input" {}
variable "pri_sub_6b_cidr_input" {}
variable "db_username_input" {}
variable "db_password_input" {}
#variable "certificate_domain_name" {}
#variable "additional_domain_name" {}




