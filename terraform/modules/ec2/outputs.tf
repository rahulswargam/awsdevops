# Outputs of the Instance

output "instance_public_ip" {
  value = aws_instance.devops_services.public_ip
}

# Output the security group ID and key pair name
output "jenkins_security_group_id" {
  value = aws_security_group.devops_sg.id
}

output "key_pair_name" {
  value = data.aws_key_pair.devops_keypair.key_name
}