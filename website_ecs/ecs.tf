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
      "cpu": 256,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION
  requires_compatibilities = ["EC2"] # Stating that we are using ECS Fargate
#  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn = aws_iam_role.ecsTaskExecutionRole.arn

  tags = local.tags
}

resource "aws_ecs_service" "anne-test-website-ecs-service" {
  name            = "anne-test-website-ecs-service"
  cluster         = aws_ecs_cluster.anne_test_website_ecs_cluster.id
  task_definition      = "${aws_ecs_task_definition.anne_test_website_ecs_task.arn}"
  launch_type = "EC2"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets = local.private_subnets[*].id
    assign_public_ip = true
    security_groups = [aws_security_group.load_balancer_security_group-1.id]
  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.target_group.arn
#    container_name   = "anne"
#    container_port   = 80
#  }

  tags = local.tags

}