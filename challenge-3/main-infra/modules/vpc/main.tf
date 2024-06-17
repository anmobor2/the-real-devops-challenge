# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }


resource "aws_vpc" "this" {
  cidr_block = var.cidr
  tags = var.tags
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index] # Asignar AZ explícitamente
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnets[count.index]
  tags = var.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = var.tags
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "this" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = var.tags
}

resource "aws_eip" "nat" {
  count = length(var.public_subnets)
  domain = "vpc"
  tags = var.tags
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = var.tags
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id  # Elimina count.index
}

data "aws_route_table" "private" {
  count = length(var.private_subnets) # Iterar sobre el número de subredes
  subnet_id = element(aws_subnet.private.*.id, count.index)
  depends_on = [aws_route_table_association.private]
}
#  depends_on = [aws_route_table_association.private]

resource "aws_route" "private" {
  route_table_id         = aws_default_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id

  lifecycle {
    ignore_changes = [nat_gateway_id]
  }
}

resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = var.tags
}