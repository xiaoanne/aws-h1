resource "aws_internet_gateway" "anne_gateway" {
  vpc_id = aws_vpc.anne_test_website_vpc.id

  tags = {
    Name = "anne"
  }
}

resource "aws_route_table" "anne_rt" {
  vpc_id = aws_vpc.anne_test_website_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.anne_gateway.id
  }

  tags = {
    Name = "anne"
  }
}

resource "aws_route_table_association" "anne_tb_association" {
  count          = length(local.private_subnets)
  route_table_id = aws_route_table.anne_rt.id
  subnet_id      = local.private_subnets[count.index].id
  #  subnet_id = local.private_subnets[count.index]["id"]
}

#resource "aws_route_table_association" "anne_tb_association_2" {
#  route_table_id = aws_route_table.anne_rt.id
#  subnet_id      = aws_subnet.private_2.id
#}
#
#resource "aws_route_table_association" "anne_tb_associatio_3" {
#  route_table_id = aws_route_table.anne_rt.id
#  subnet_id      = aws_subnet.private_3.id
#}