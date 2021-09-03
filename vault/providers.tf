provider "aws" {

  profile                 = "terraform"
  shared_credentials_file = "./credentials"
  region                  = var.aws_region
}

provider "vault" {
  address = "http://192.168.1.11:8080"
  token   = var.token


}