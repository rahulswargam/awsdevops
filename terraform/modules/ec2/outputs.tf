# Outputs of the Instance

output "jenkins_security_group_id" {
  value = aws_security_group.devops_sg.id
}

output "key_pair_name" {
  value = data.aws_key_pair.devops_keypair.key_name
}

output "instance_public_ips" {
  value = aws_instance.devops_services[*].public_ip
}
