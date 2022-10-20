resource "aws_ecs_cluster" "anne_test_website_ecs_cluster" {
  name = local.ecs_cluster_name

  tags = {
    Name = "anne"
  }
}