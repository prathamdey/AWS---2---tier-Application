terraform {
  backend "s3" {
    bucket = "statefileterraformprat"
    key    = "backend/statefile_aws_multitier.tf"
    #backend does not support the variable
    #region = var.aws_region
    region = "us-east-1"
    #dynamodb_table = "remote_table"
  }
}  