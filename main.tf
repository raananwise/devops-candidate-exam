
data "aws_availability_zones" "available" {}


resource "aws_vpc" "vpc" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Avi_VPC"
  }

}
resource "aws_eip" "terraformtraining-nat" {
  vpc = true
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = data.aws_vpc.vpc.id
}


//private subnets for Apps

resource "aws_subnet" "PrivateSubnet1" {

  cidr_block        = "10.0.1.0/24"
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]

}

resource "aws_subnet" "PrivateSubnet2" {

  cidr_block        = "10.0.2.0/24"
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


resource "aws_iam_policy" "Ec2LaunchPolicy_Avi" {

name = "Ec2LaunchPolicy_Avi"
policy = <<EOF
{
  
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "iam:PassRole",
            "iam:ListInstanceProfiles",
            "ec2:*"
        ],
        "Resource": "*"
    }]
}
   
EOF


}

resource "aws_iam_role_policy_attachment" "Ec2LaunchPolicy_Avi" {
  role       = "arn:aws:sts::007974164823:assumed-role/jenkins-role/i-0e71d6821854db9d0"
  policy_arn = aws_iam_policy.Ec2LaunchPolicy_Avi.arn
}