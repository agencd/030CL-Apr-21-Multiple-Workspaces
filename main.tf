terraform {
  backend "s3" {
    bucket = "mytfstatebackend"
    key    = "multiple_workspaces_terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    tfe = {
      version = "~> 0.64.0"
    }
  }
}

provider "tfe" {
  version  = "~> 0.64.0"
}

variable "environments" {
    type = list(string)
    default = [ "dev", "test", "sandbox", "uat", "prod"]
}

resource "tfe_workspace" "test" {
  for_each     = toset(var.environments)
  name         = "network-${each.key}"
  organization = "CL030-DevOps"
}