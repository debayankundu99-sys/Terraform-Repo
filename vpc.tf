resource "aws_vpc" "debayanvpc" {
  cidr_block = "100.10.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true


  tags = {
    Name = "testvpc"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.debayanvpc.id


  tags = {
    Name = "testigw"
  }
}

resource "aws_subnet" "public_az_a" {
  vpc_id = aws_vpc.debayanvpc.id
  cidr_block = "100.10.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "public-az_a"
  }
}

resource "aws_subnet" "public_az_b" {
  vpc_id                  = aws_vpc.debayanvpc.id
  cidr_block              = "100.10.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "public-az_b"
  }
}

resource "aws_subnet" "private_az_a" {
  vpc_id = aws_vpc.debayanvpc.id
  cidr_block = "100.10.3.0/24"
  availability_zone = "us-east-1a"


  tags = {
    Name = "private-az_a"
  }
}

resource "aws_subnet" "private_az_b" {
  vpc_id = aws_vpc.debayanvpc.id
  cidr_block = "100.10.4.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name = "private-az_b"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_az_a.id


  tags = {
    Name = "test_net_gw"
  }
}


resource "aws_route_table" "public_rt1" {
  vpc_id = aws_vpc.debayanvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt1"
  }
}


resource "aws_route_table_association" "public_assoc_az_a" {
  subnet_id = aws_subnet.public_az_a.id
  route_table_id = aws_route_table.public_rt1.id
}

resource "aws_route_table_association" "public_assoc_az_b" {
  subnet_id = aws_subnet.public_az_b.id
  route_table_id = aws_route_table.public_rt1.id
}

resource "aws_route_table" "private_rt1" {
 vpc_id = aws_vpc.debayanvpc.id


 route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name ="private_rt1"
  }
}

resource "aws_route_table_association" "private_az_a" {
  subnet_id = aws_subnet.private_az_a.id
  route_table_id = aws_route_table.private_rt1.id
}


resource "aws_route_table_association" "private_az_b" {
  subnet_id = aws_subnet.private_az_b.id
  route_table_id = aws_route_table.private_rt1.id
}
