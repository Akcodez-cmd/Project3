
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  backend "s3" {
    bucket       = "project3-terraform-state-496663581580"
    key          = "project3/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
