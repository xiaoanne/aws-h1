locals {
  ecs_cluster_name = "anne-test-website"
}

locals {
  private_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = [aws_subnet.private_1, aws_subnet.private_2, aws_subnet.private_3]
}

locals {
  tags = {
    Name = "anne"
  }
}
