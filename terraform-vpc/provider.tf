terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"

    }
  }

  backend "s3" {
    bucket = "terraform-state-file12345"
    key    = "key/terraform.tfstate"
    region = "ap-south-1"

  }
}

provider "aws" {
  region = "ap-south-1"
}