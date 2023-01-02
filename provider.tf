terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = "us-east-1"
    bucket = "currency-explorer-tf-state"
    key    = "state"
  }
}

provider "aws" {
  region = "us-east-1"
}