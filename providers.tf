terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3"{
    bucket = "orchsky-terraform-backend"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}