resource "aws_vpc" "cloudpunch_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "cloudpunch-vpc"
  }
}

resource "aws_subnet" "cloudpunch_subnet" {
  count = 2

  vpc_id                  = aws_vpc.cloudpunch_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.cloudpunch_vpc.cidr_block, 8, count.index)
  availability_zone       = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudpunch-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "cloudpunch_igw" {
  vpc_id = aws_vpc.cloudpunch_vpc.id

  tags = {
    Name = "cloudpunch-igw"
  }
}

resource "aws_route_table" "cloudpunch_route_table" {
  vpc_id = aws_vpc.cloudpunch_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudpunch_igw.id
  }

  tags = {
    Name = "cloudpunch-route-table"
  }
}

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.cloudpunch_subnet[count.index].id
  route_table_id = aws_route_table.cloudpunch_route_table.id
}

