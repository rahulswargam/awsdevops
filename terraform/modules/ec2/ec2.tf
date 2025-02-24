

# EC2 Instance Creation

resource "aws_instance" "devops_services" {
  ami                    = data.aws_ami.rhel_9.id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.devops_keypair.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  user_data              = file(var.user_data)
  # tags = var.tags
}