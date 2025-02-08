terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "terraform_deploy"
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
      name              = "private_sn_us_east_1b"
      availability_zone = "us-east-1b"
  }]

  subnets_public = [{
    cidr_block        = "10.0.20.0/24"
    name              = "public_sn_us_east_1a"
    availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.21.0/24"
      name              = "public_sn_us_east_1b"
      availability_zone = "us-east-1b"
  }]
}

module security_group {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
  name = "mgmt-sg"
  description = "Management security group allowing SSH and HTTP"

  ingress_rules = [{
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
    name = "SSH"
  },
  {
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80
    name = "HTTP"
  },
  {
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443
    name = "HTTP"
  }]

  egress_rules = []
}