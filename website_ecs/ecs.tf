resource "aws_ecs_cluster" "anne_test_website_ecs_cluster" {
  name = local.ecs_cluster_name

  tags = local.tags
}

resource "aws_ecs_task_definition" "anne_test_website_ecs_task" {
  family                   = "anne_test_website_ecs_task" # Naming our first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "anne",
      "image": "${aws_ecr_repository.anne_test_website.repository_url}:10_22",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["EC2"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = aws_iam_role.anne_test_ecs_task_role.arn
  task_role_arn = aws_iam_role.anne_test_ecs_task_role.arn

  tags = local.tags
}

resource "aws_ecs_service" "anne-test-website-ecs-service" {
  name            = "anne-test-website-ecs-service"
  cluster         = aws_ecs_cluster.anne_test_website_ecs_cluster.id
  task_definition = aws_ecs_task_definition.anne_test_website_ecs_task.arn
  desired_count   = 1
#  iam_role = aws_iam_role.anne_test_ecs_task_role.arn

  network_configuration {
    subnets = local.private_subnets[*].id
    assign_public_ip = false
    security_groups = [aws_security_group.load_balancer_security_group-1.id]
  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.target_group.arn
#    container_name   = "anne"
#    container_port   = 80
#  }

  tags = local.tags

}