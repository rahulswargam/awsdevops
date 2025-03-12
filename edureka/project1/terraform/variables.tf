variable "aws_region" {
  default     = "ap-south-1"
  type        = string
  description = "AWS Region"
}

variable "keypair_name" {
  default     = "devopskp"
  type        = string
  description = "Keypair Name"
}

variable "user_data" {
  type        = list(string)
  description = "User Data Path"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
}