// backend
terraform {
  backend "s3" {
    bucket = "arkanion-tf-state"
    key    = "main.tfstate"
    region = "eu-west-2"
    encrypt = true
    profile = "personal-aws-fidroy" # ~/.aws profile
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
  profile = "personal-aws-fidroy"
}