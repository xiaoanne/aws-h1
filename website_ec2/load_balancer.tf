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

#resource "aws_lb_target_group_attachment" "anne_lb_tg_attachment" {
#  target_group_arn = aws_lb_target_group.anne_lb_tg.arn
##  target_id        = aws_instance.anne_test_website_ec2[count.index].id
#  target_id        = aws_autoscaling_group.anne_test-asg.id
#  port             = 80
#}

resource "aws_lb" "anne_test_website_lb_target_group" {
  name               = "anne-lb-target-group"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = [aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.private_3.id]

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