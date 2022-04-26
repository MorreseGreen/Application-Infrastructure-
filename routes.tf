resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "nat-route-table"
  }
}

resource "aws_route_table" "internet_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "internet-route-table"
  }
}

# ASSOCIATE ROUTE TABLE -- PRIVATE LAYER
resource "aws_route_table_association" "nat_route_table_association_private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- DATA LAYER
resource "aws_route_table_association" "nat_route_table_association_data-a" {
  subnet_id      = aws_subnet.data-a.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- PUBLIC LAYER
resource "aws_route_table_association" "internet_route_table_association_public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.internet_route_table.id
}

# ASSOCIATE ROUTE TABLE -- PRIVATE LAYER
resource "aws_route_table_association" "nat_route_table_association_private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- DATA LAYER
resource "aws_route_table_association" "nat_route_table_association_data-b" {
  subnet_id      = aws_subnet.data-b.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- PUBLIC LAYER
resource "aws_route_table_association" "internet_route_table_association_public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.internet_route_table.id
}