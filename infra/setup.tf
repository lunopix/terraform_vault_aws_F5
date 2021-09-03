terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lunopix"

    workspaces {
      name = "infra_workspace"
    }
  }
}