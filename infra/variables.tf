variable "token" {
  description = "Veuillez saisir le token pour VAULT"
  sensitive   = true
  type        = string


}


variable "path" {
  type    = string
  default = "aws"

}

variable "terraform_role_name" {
  type    = string
  default = "TERRAFORM_ROLE"

}

variable "region" {
  type    = string
  default = "us-east-1"
}


variable "monIP" {
  description = "Veuillez saisir votre adresse IP publique"
  type        = string

}
