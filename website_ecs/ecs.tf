resource "aws_ecs_cluster" "anne_test_website_ecs_cluster" {
  name = local.ecs_cluster_name

  tags = local.tags
}

#resource "aws_ecs_task_definition" "anne_test_website_ecs_task" {
#  family                   = "anne_test_website_ecs_task" # Naming our first task
#  container_definitions    = <<DEFINITION
#  [
#    {
#      "name": "anne_test_website_ecs_tas",
#      "image": "${aws_ecr_repository.anne_test_website.repository_url}",
#      "essential": true,
#      "portMappings": [
#        {
#          "containerPort": 3000,
#          "hostPort": 3000
#        }
#      ],
#      "memory": 512,
#      "cpu": 256
#    }
#  ]
#  DEFINITION
#  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
#  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
#  memory                   = 512         # Specifying the memory our container requires
#  cpu                      = 256         # Specifying the CPU our container requires
#  execution_role_arn       = aws_iam_role.anne_test_ecs_task_role.arn
#
#  tags = local.tags
#}
