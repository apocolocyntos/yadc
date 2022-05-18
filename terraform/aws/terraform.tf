terraform {
  cloud {
    organization = "yet-another-datacenter"
    workspaces {
      name = "aws"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
