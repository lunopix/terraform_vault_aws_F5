resource "aws_iam_role" "TERRAFORMFULL" {
  name               = var.terraform_role_name
  assume_role_policy = data.aws_iam_policy_document.AllowAssumeRole.json

}

resource "aws_iam_role_policy_attachment" "LinkRoleToPermissions" {
  role       = aws_iam_role.TERRAFORMFULL.name
  policy_arn = data.aws_iam_policy.Permissions.arn
}

resource "vault_aws_secret_backend" "vault_aws" {
  access_key                = data.aws_ssm_parameter.ACCESS_KEY.value
  secret_key                = data.aws_ssm_parameter.SECRET_KEY.value
  region                    = var.aws_region
  path                      = var.path
  default_lease_ttl_seconds = 1800
  max_lease_ttl_seconds     = 3600

}

resource "vault_aws_secret_backend_role" "vault_aws_role" {
  backend         = vault_aws_secret_backend.vault_aws.path
  credential_type = "assumed_role"
  name            = var.terraform_role_name
  role_arns       = ["arn:aws:iam::${data.aws_caller_identity.MonCompteAWS.account_id}:role/${var.terraform_role_name}"]

}