#resource "aws_iam_role" "anne_test_ecs_task_role" {
#  name               = "anne-test-ecs-task-iam-role"
#  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
#
#  tags = local.tags
#}
#
#resource "aws_iam_role_policy_attachment" "anne_test_iam_policy" {
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#  role       = aws_iam_role.anne_test_ecs_task_role.name
#}