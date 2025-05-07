terraform {
  required_version = ">= 1.10.5"

  # backend "s3" {
  #   bucket = "liftoff-tf-s3-bucket"
  #   key = "liftoff/state.tfstate"
  #   region = "us-east-1"
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}
