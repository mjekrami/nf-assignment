resource "aws_route_table" "routing_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.routing_table.id
}