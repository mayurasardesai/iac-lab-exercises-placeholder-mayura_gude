resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-igw", var.prefix)
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_subnet_1.id
  subnet_id     = [for key, subnet in aws_subnet.public_subnets : subnet.id][0]

  tags = {
    Name = format("%s-nat-gateway", var.prefix)
  }
}

# Public Subnet 1: Availability Zone 1
resource "aws_subnet" "public_subnets" {
  count = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone       = format("%s%s", var.region, var.subnets[count.index].az)
  map_public_ip_on_launch = true
  tags = {
    Name = format("%s-public-subnet-%s", var.prefix, count.index)
  }
}


# Private Subnet 1: Availability Zone 2
resource "aws_subnet" "private_subnets" {
  count = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[count.index + 2].cidr
  availability_zone       = format("%s%s", var.region, var.subnets[count.index + 2].az)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-private-subnet-%s", var.prefix, count.index + 2)
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-public-route-table", var.prefix)
  }
}

resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = format("%s-private-route-table", var.prefix)
  }
}

resource "aws_route_table_association" "public_subnets" {
  count = 2

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.private_routetable.id
}

resource "aws_route_table_association" "private_subnets" {
  count = 2

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_routetable.id
}
