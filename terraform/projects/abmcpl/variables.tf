variable "keypair_name" {
  default     = "devopskp"
  type        = string
  description = "keypair name"
}

variable "user_data" {
  default     = "../../common/jenkins/jenkins.sh"
  type        = string
  description = "user data path"
}

variable "project_name" {
  default     = "abmcpl"
  type        = string
  description = "Name of the Project"
}