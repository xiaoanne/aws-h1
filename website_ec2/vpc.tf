resource "aws_vpc" "anne_test_website_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "anne"
  }
}

# implement for_each way

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.anne_test_website_vpc.id
  cidr_block              = local.private_subnet[0]
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "anne"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.anne_test_website_vpc.id
  cidr_block              = local.private_subnet[1]
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "anne"
  }
}

resource "aws_subnet" "private_3" {
  vpc_id                  = aws_vpc.anne_test_website_vpc.id
  cidr_block              = local.private_subnet[2]
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = false

  tags = {
    Name = "anne"
  }
}