variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "token" {
  sensitive   = true
  type        = string
  description = "Veuillez saisir le token pour vault"

}

variable "terraform_permissions_name" {
  type    = string
  default = "TERRAFORM_FULL_EC2_VPC_SSM"
}

variable "terraform_role_name" {
  type    = string
  default = "TERRAFORM_ROLE"

}

variable "path" {
  type    = string
  default = "aws"

}