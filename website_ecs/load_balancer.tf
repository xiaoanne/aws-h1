#resource "aws_alb" "application_load_balancer" {
#  name               = "test-lb-tf" # Naming our load balancer
#  load_balancer_type = "application"
#  subnets            = local.private_subnets[*].id
#  # Referencing the security group
#  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#
#  tags = local.tags
#}
#
#resource "aws_lb_target_group" "target_group" {
#  name        = "target-group"
#  port        = 80
#  protocol    = "HTTP"
#  target_type = "ip"
#  vpc_id      = aws_vpc.anne_test_website_vpc.id
#
#  tags = local.tags
#}
#
#resource "aws_lb_listener" "listener" {
#  load_balancer_arn = aws_alb.application_load_balancer.arn # Referencing to load balancer
#  port              = "80"
#  protocol          = "HTTP"
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.target_group.arn # Referencing to tagrte group
#  }
#
#  tags = local.tags
#}