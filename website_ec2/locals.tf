locals {
  count = 2
}

locals {
  name = "anne_test_website"
}

locals {
  available_zone_1 = "ap-southeast-2a"
}

locals {
  available_zone_2 = "ap-southeast-2b"
}

locals {
  private_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
}

locals {
  type        = "list"
  private_ips = ["10.0.1.1", "10.0.2.1"]
}

locals {
  ec2_ami = "ami-067e6178c7a211324"
}

locals {
  ec2_type = "t2.micro"
}

locals {
  ports_in = [
    443,
    80,
    23
  ]
  ports_out = [
    0
  ]
}