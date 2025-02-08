resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.vpc.id

  for_each          = {for index, sn in var.subnets_private: sn.cidr_block => sn}
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id

  for_each          = {for index, sn in var.subnets_public: sn.cidr_block => sn}
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  count = length(var.subnets_public) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-${var.name}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public_rtb"
  }
}

resource "aws_route" "igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway[0].id
}

resource "aws_route_table_association" "public-rtb-association" {
  for_each = aws_subnet.public_subnet
  route_table_id = aws_route_table.public_route_table.id
  subnet_id =  each.value.id
}