# Fetch the Key pair

data "aws_key_pair" "devops_keypair" {
  key_name = var.keypair_name
}