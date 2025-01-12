resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.vpc.id

  for_each          = var.subnets_private
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id

  for_each          = var.subnets_public
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}