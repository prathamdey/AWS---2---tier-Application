##############################################
## Module Desc: Create key pair pub file
## Date: 09/08/2023
## Ver: v1
##############################################


resource "aws_key_pair" "client_key" {
  key_name   = "ansible-project-keypair"
  public_key = "../modules/key/ansible-project-keypair.pem"
}