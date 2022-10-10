resource "aws_launch_template" "anne_test_asg_template" {
  count         = length(local.private_subnet)
  image_id      = local.ec2_ami
  instance_type = local.ec2_type
  key_name      = aws_key_pair.kp.key_name

  network_interfaces {
    security_groups             = [aws_security_group.allow_web.id]
    subnet_id                   = aws_subnet.private[count.index].id
    associate_public_ip_address = true
  }

  placement {
    availability_zone = data.aws_availability_zones.available.names[count.index]
  }

  lifecycle {
    create_before_destroy = true
  }

  user_data = filebase64("web.conf")
}

resource "aws_autoscaling_group" "anne_test-asg" {
  count            = length(local.private_subnet)
  max_size         = 6
  min_size         = 2
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.anne_test_asg_template[count.index].id
    version = "$Latest"
  }
  health_check_type         = "ELB"
  health_check_grace_period = 60
  target_group_arns         = [aws_lb_target_group.anne_lb_tg.arn]
}

#resource "aws_autoscaling_policy" "anne_test_asg_up" {
#  autoscaling_group_name = ""
#  name                   = ""
#}