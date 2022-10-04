resource "aws_vpc" "anne_test_website_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "anne"
  }
}

resource "aws_subnet" "private" {
  count                   = length(local.private_subnet)
  vpc_id                  = aws_vpc.anne_test_website_vpc.id
  cidr_block              = local.private_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "anne"
  }
}