##############################################
## Module Desc: Create a VPC, IGW, Subnet
## Date: 08/08/2023
## Ver: v1
##############################################


# Create a VPC
resource "aws_vpc" "main" {
  
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  cidr_block = var.cidr_vpc

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#Create an internet gateway and attach to the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# use data source to get all avalablility zones in region (region is taking from the provider block) 
data "aws_availability_zones" "all" {}

#Create a public subnet 1a
resource "aws_subnet" "pub_sub_1a" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[0]
  map_public_ip_on_launch   = true
  cidr_block                = var.pub_sub_1a_cidr

  tags = {
    Name = "${var.project_name}-Pub_Sub_1a"
  }
}

#Create a public subnet 2b
resource "aws_subnet" "pub_sub_2b" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[1]
  map_public_ip_on_launch   = true
  cidr_block                = var.pub_sub_2b_cidr

  tags = {
    Name = "${var.project_name}-Pub_Sub_2b"
  }
}


# create route table and add public route
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-Pub_Sub_RT"
  }
}

# associate public subnet pub-sub-1a to public route table

resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
  subnet_id      = aws_subnet.pub_sub_1a.id
  route_table_id = aws_route_table.pub_rt.id
}


# associate public subnet az2 to "public route table"

resource "aws_route_table_association" "pub-sub-2b_route_table_association" {
  subnet_id      = aws_subnet.pub_sub_2b.id
  route_table_id = aws_route_table.pub_rt.id
}


# create private app subnet pri-sub-3a
resource "aws_subnet" "pri_sub_3a" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[0]
  map_public_ip_on_launch   = false
  cidr_block                = var.pri_sub_3a_cidr

  tags = {
    Name = "${var.project_name}-Pri_Sub_3a"
  }
}

# create private app pri-sub-4b
resource "aws_subnet" "pri_sub_4b" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[1]
  map_public_ip_on_launch   = false
  cidr_block                = var.pri_sub_4b_cidr

  tags = {
    Name = "${var.project_name}-Pri_Sub_4b"
  }
}

# create private data subnet pri-sub-5a
resource "aws_subnet" "pri_sub_5a" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[0]
  map_public_ip_on_launch   = false
  cidr_block                = var.pri_sub_5a_cidr

  tags = {
    Name = "${var.project_name}-Pri_Sub_5a"
  }
}

# create private data subnet pri-sub-6b
resource "aws_subnet" "pri_sub_6b" {
  vpc_id                    = aws_vpc.main.id
  availability_zone         = data.aws_availability_zones.all.names[1]
  map_public_ip_on_launch   = false
  cidr_block                = var.pri_sub_6b_cidr

  tags = {
    Name = "${var.project_name}-Pri_Sub_6b"
  }
}