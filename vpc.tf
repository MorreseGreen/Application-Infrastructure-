resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "Wordpress-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "talent-academy-igw"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public-a.id

  tags = {
    Name = "talent-academy-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add a 
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}