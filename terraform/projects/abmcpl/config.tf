# Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

# Region of EC2

provider "aws" {
  region = "ap-south-1"
}

# To save the State File in S3 Bucket

terraform {
  backend "s3" {
    bucket = "tfstatefiles3bucket"
    key    = "tfstatefile/devopspractice.tfstate"
    region = "ap-south-1"
  }
}