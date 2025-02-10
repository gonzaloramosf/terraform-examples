provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "liftoff"
}

resource "aws_vpc" "liftoff-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "liftoff-subnet" {
  source = "./modules/subnet"

  availability_zone = var.availability_zone
  env_prefix        = var.env_prefix
  subnet_cidr_block = var.subnet_cidr_block
  vpc_id            = aws_vpc.liftoff-vpc.id
}

module "liftoff-webserver" {
  source = "./modules/webserver"

  availability_zone      = var.availability_zone
  env_prefix             = var.env_prefix
  image_name             = var.image_name
  instance_type          = var.instance_type
  my_ip                  = var.my_ip
  my_public_key_location = var.my_public_key_location
  subnet_id              = module.liftoff-subnet.subnet.id
  vpc_id                 = aws_vpc.liftoff-vpc.id
}
