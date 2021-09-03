data "aws_iam_policy" "Permissions" {
  name = var.terraform_permissions_name

}

data "aws_caller_identity" "MonCompteAWS" {

}

data "aws_iam_policy_document" "AllowAssumeRole" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.MonCompteAWS.account_id}:user/terraform"]
    }
  }

}

data "aws_ssm_parameter" "ACCESS_KEY" {
  name = "/terraform/ACCESS_KEY"
}
data "aws_ssm_parameter" "SECRET_KEY" {
  name = "/terraform/SECRET_KEY"
}