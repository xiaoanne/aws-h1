resource "aws_lb_target_group" "anne_lb_tg" {
  name     = "anne-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.anne_test_website_vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

#resource "aws_lb_target_group_attachment" "anne_lb_tg_attachment_1" {
#  target_group_arn = aws_lb_target_group.anne_lb_tg.arn
#  target_id        = aws_instance.anne_test_website_ec2_1.id
#  port             = 80
#}

resource "aws_lb" "anne_test_website_lb_target_group" {
  name               = "anne-lb-target-group"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = local.private_subnets[*].id

  tags = {
    name = "anne"
  }
}

resource "aws_lb_listener" "anne_test_lb_listener" {
  load_balancer_arn = aws_lb.anne_test_website_lb_target_group.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anne_lb_tg.arn
  }
}