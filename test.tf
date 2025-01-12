terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "vpc_us_east_1"

  subnets_private = [{
    cidr_block        = "10.0.10.0/24"
    name              = "private_sn_us_east_1a"
    availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.11.0/24"
      name              = "private_sn_us_east_1a"
      availability_zone = "us-east-1b"
  }]

  subnets_public = [{
    cidr_block        = "10.0.20.0/24"
    name              = "public_sn_us_east_1a"
    availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.21.0/24"
      name              = "public_sn_us_east_1a"
      availability_zone = "us-east-1b"
  }]
}