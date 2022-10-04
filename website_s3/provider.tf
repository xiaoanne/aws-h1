terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = var.aws_version
    }
  }

  required_version = var.tf_version
}

provider "aws" {
  region  = var.region
}