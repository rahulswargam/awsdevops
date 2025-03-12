module "ec2" {
  source = "../../../terraform/modules/ec2"

  ami            = data.aws_ami.ubuntu.id
  key_name       = var.keypair_name
  instance_names = var.instance_names
  instance_count = var.instance_count
  user_data      = var.user_data[0]

  tags = {
    Project     = "Edureka"
    Environment = "dev"
  }
}