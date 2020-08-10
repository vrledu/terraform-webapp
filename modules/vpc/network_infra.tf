#local varibales
locals {
  azs_names = data.aws_availability_zones.azs.names
}

#vpc
resource "aws_vpc" "web-app-vpc" {

  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.vpc_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "web-app-vpc"
  }
}

#public subnets
resource "aws_subnet" "public-subnet-1" {

  availability_zone = local.azs_names[0]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.public_subnet_1_cidr
  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {

  availability_zone = local.azs_names[1]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.public_subnet_2_cidr
  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {

  availability_zone = local.azs_names[2]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.public_subnet_3_cidr
  tags = {
    Name = "Public-Subnet-3"
  }
}

#private subnets
resource "aws_subnet" "private-subnet-1" {

  availability_zone = local.azs_names[0]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.private_subnet_1_cidr
  tags = {
    Name = "Private-Subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {

  availability_zone = local.azs_names[1]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.private_subnet_2_cidr
  tags = {
    Name = "Private-Subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {

  availability_zone = local.azs_names[2]
  vpc_id            = aws_vpc.web-app-vpc.id
  cidr_block        = var.private_subnet_3_cidr
  tags = {
    Name = "Private-Subnet-1"
  }
}

#public route-table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.web-app-vpc.id
  tags = {
    Name = "Public-Route-Table"
  }
}

#private route-table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.web-app-vpc.id
  tags = {
    Name = "Private-Route-Table"
  }
}

#public route-table association
resource "aws_route_table_association" "public-subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

resource "aws_route_table_association" "public-subnet-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-3.id
}

#private route-table association
resource "aws_route_table_association" "private-subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}

resource "aws_route_table_association" "private-subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}

resource "aws_route_table_association" "private-subnet-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.private-subnet-3.id
}

/*
#eip
resource "aws_eip" "elastic-ip-addr-nat-gateway" {
  vpc                       = true
  associate_with_private_ip = var.nat_gateway_private_ip
  tags = {
    Name = "Elastic-IP"
  }
}

#nat-gateway
resource "aws_nat_gateway" "nat-gateway" {
  count         = 1
  allocation_id = aws_eip.elastic-ip-addr-nat-gateway.id
  subnet_id     = aws_subnet.public-subnets[count.index].id
  tags = {
    Name = "Nat-Gateway"
  }
  depends_on = [aws_eip.elastic-ip-addr-nat-gateway]
}

#nat-gateway route-table
resource "aws_route" "nat-gateway-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
*/

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.web-app-vpc.id
  tags = {
    Name = "Internet-Gateway"
  }
}

resource "aws_route" "public-internet-gateway" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.internet-gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
