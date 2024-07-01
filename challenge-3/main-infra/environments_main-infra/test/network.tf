resource "aws_vpc" "toni_vpc" {
  cidr_block           = "10.0.0.0/24" # 512 IPs 
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "toni-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.toni_vpc.id
  count             = 3
  cidr_block        = cidrsubnet(aws_vpc.toni_vpc.cidr_block, 4, count.index) #index means 3rd subnet 
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "toni-public-subnet-${count.index + 1}"
  }

}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.toni_vpc.id
  count             = 3
  cidr_block        = cidrsubnet(aws_vpc.toni_vpc.cidr_block, 4, count.index + 3) #index means 3rd subnet 
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = {
    Name = "toni-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = aws_vpc.toni_vpc.id
  tags = {
    Name = "toni-igw"
  }
}

resource "aws_route_table" "route_table_public_subnet" {
  vpc_id = aws_vpc.toni_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc.id
  }
  tags = {
    Name = "Public subnet Route Table"
  }

}

resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.route_table_public_subnet.id
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)

}

resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_vpc]

}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)
  depends_on    = [aws_internet_gateway.igw_vpc]
  tags = {
    Name = "Nat Gateway"
  }
}

resource "aws_route_table" "route_table_private_subnet" {
  depends_on = [aws_nat_gateway.nat-gateway]
  vpc_id     = aws_vpc.toni_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }
  tags = {
    Name = "Private subnet Route Table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.route_table_private_subnet.id
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)

}