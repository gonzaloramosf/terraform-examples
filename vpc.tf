provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "liftoff"
}

data "aws_availability_zones" "azs" {}

module "liftoff-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"

  name = "liftoff-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/liftoff-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/liftoff-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/liftoff-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
