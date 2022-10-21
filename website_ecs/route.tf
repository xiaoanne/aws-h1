resource "aws_internet_gateway" "anne_gateway" {
  vpc_id = aws_vpc.anne_test_website_vpc.id

  tags = local.tags
}

resource "aws_route_table" "anne_rt" {
  vpc_id = aws_vpc.anne_test_website_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.anne_gateway.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "anne_tb_association" {
  count          = length(local.private_subnets)
  route_table_id = aws_route_table.anne_rt.id
  subnet_id      = local.private_subnets[count.index].id
}