# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = ""
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

# SSH Key Pair Name
variable "key_name" {
  description = "The name of the SSH Key Pair to use for EC2 Instance Access"
  type        = string
  default     = ""
}

variable "keypair_name" {
  default     = ""
  type        = string
  description = "keypair name"
}

# Security Group Name
variable "name" {
  description = "The Name of the Security Group"
  type        = string
  default     = ""
}

# Security Group Description
variable "description" {
  description = "Description for the Security Group"
  type        = string
  default     = "This Security Group is for AWS and DevOps Practices"
}

# Allowed Inbound Protocol
variable "ingress_protocol" {
  description = "The Protocol to allow for Ingress Rules"
  type        = string
  default     = "tcp"
}

# List of Ingress Ports
variable "ingress_from_port" {
  description = "List of Ports to allow Inbound Traffic"
  type        = list(number)
  default     = [80, 22, 443, 8080]
}

# Allowed Outbound Protocol
variable "egress_protocol" {
  description = "The Protocol to allow for Egress Rules"
  type        = string
  default     = "-1"
}

# Outbound Port (Used for both from and to ports)
variable "egress_port" {
  description = "The Port to allow Outbound Traffic"
  type        = number
  default     = 0
}

# CIDR Blocks for Security Group Rules
variable "cidr_blocks" {
  description = "List of CIDR Blocks for Inbound and Outbound Traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 Instance Type
variable "instance_type" {
  description = "The Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

# User Data Script
variable "user_data" {
  description = "Path to the User Data Script for EC2 Instance Initialization"
  type        = string
  default     = ""
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
}

variable "environment" {
  description = "The Environment Type"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Key-value Pairs of Tags to Assign to AWS Resources"
  type        = map(string)
  default = {
    createdBy = "Terraform"
  }
}