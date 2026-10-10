
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Project3"
      ManagedBy   = "Terraform"
      Environment = "Learning"
    }
  }
}
