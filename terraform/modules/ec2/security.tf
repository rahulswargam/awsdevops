# Create a security group for EC2

resource "aws_security_group" "devops_sg" {
  name        = var.name
  description = var.description

  # Ingress Rules for multiple ports

  dynamic "ingress" {
    for_each = toset(var.ingress_from_port)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.ingress_protocol
      cidr_blocks = var.cidr_blocks
    }
  }

  # Outbound Rules

  egress {
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.egress_protocol
    cidr_blocks = var.cidr_blocks
  }

  tags = var.tags
}