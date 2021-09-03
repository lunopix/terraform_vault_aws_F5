provider "vault" {
  address = "http://192.168.1.11:8080"
  token   = var.token
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.cred.access_key
  secret_key = data.vault_aws_access_credentials.cred.secret_key
  token      = data.vault_aws_access_credentials.cred.security_token
  region     = var.region
}
