locals {
  count = 2
}

locals {
  s3_bucket_name = "anne-test-website"
}


locals {
  name = "anne_test_website"
}

#locals {
#  available_zone_1 = "ap-southeast-2a"
#}
#
#locals {
#  available_zone_2 = "ap-southeast-2b"
#}
#
#locals {
#  available_zone_3 = "ap-southeast-2c"
#}

locals {
  private_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = [aws_subnet.private_1, aws_subnet.private_2, aws_subnet.private_3]
}

locals {
  #  ec2_ami = "ami-067e6178c7a211324"
  ec2_ami = "ami-00c5eee15c96a7182"
}

locals {
  ec2_micro  = "t2.micro"
  ec2_small  = "t2.small"
  ec2_medium = "t2.medium"
}

locals {
  ports_in = [
    22,
    80,
    443,
    8140,
  ]
  ports_out = [
    0
  ]
}