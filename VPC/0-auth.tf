terraform {
  required_providers { # tf will download all required providers automatically
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}

provider "aws" {
  # default_tags has to
  default_tags {
    tags = {
      Environment = "Class7"
      ManagedBy   = "Terraform"
      Owner       = "dc"
    }
  }

  region  = "us-east-1"
  profile = "default"
}
