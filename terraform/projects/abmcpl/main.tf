module "ec2" {
  source = "../../module/ec2"

  keypair_name = var.keypair_name
  user_data    = var.user_data
  project_name = var.project_name
}
