# EC2 Instance Creation
resource "aws_instance" "devops_services" {

  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  user_data              = file(var.user_data)

  tags = merge(
    var.tags,
    {
      Name = var.instance_names[count.index]
    }
  )
}
