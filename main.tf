
data "aws_availability_zones" "available" {}


resource "aws_vpc" "vpc" {

  id         = data.aws_vpc.vpc.id
  cidr_block = "10.0.0.0/16"

}
resource "aws_eip" "terraformtraining-nat" {
  vpc = true
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = data.aws_vpc.vpc.id
}


//private subnets for Apps

resource "aws_subnet" "PrivateSubnet1" {

  cidr_block        = locals.vpc_cidr_blocks[0]
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]

}

resource "aws_subnet" "PrivateSubnet2" {

  cidr_block        = locals.vpc_cidr_blocks[1]
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]

}

#Routing#
resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_nat_gateway.nat.id
  }

}


resource "aws_route_table_association" "PrivateRoute1" {
  subnet_id      = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

resource "aws_route_table_association" "PrivateRoute2" {
  subnet_id      = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

