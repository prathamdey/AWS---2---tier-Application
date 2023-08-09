##########################################################
## Module Desc: Create a DB Subnet group and RDS instance
## Date: 08/08/2023
## Ver: v1
##########################################################

# Create a DB subnet group to provision the RDS instacne
resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_name
  #private subnet IDs
  subnet_ids = [var.pri_sub_5a_id, var.pri_sub_6b_id] 
}

# Create a RDS instance
resource "aws_db_instance" "db" {
  identifier              = "bookdb-instance-demo"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  #db_name                 = var.db_name_rds
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id] # Replace with your desired security group ID

  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  tags = {
    Name = "${var.project_name}-rds"
  }
}