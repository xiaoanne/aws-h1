# Here you can choose either to use aws_launch_template or aws_launch_configuration as template is recommended in AWS.
resource "aws_launch_template" "anne_test_asg_template" { # Not specifying the name due to terraform complaining about launch template being used already.
  name          = "anne-template"
  image_id      = local.ec2_ami
  instance_type = local.ec2_type
  key_name      = aws_key_pair.kp.key_name

  network_interfaces {
    security_groups = [aws_security_group.allow_web.id] # if not specified in network interface, need to use vpc_security_group_ids attribute.
    #    subnet_id                   = aws_subnet.private_3.id           # no need to specify subnet so the scaled up instance can locate in different subnets/AZs.
    associate_public_ip_address = true
  }

  user_data  = filebase64("web.conf") # use filebase64 not file() function to avoid error of expecting base64encode format.
  depends_on = [aws_key_pair.kp, tls_private_key.anne_key_pair]
}

resource "aws_autoscaling_group" "anne_test-asg" {
  name             = "anne_test_asg_group"
  max_size         = 6
  min_size         = 3
  desired_capacity = 3
  launch_template {
    id      = aws_launch_template.anne_test_asg_template.id
    version = "$Latest"
  }
  vpc_zone_identifier       = local.private_subnets[*].id
  health_check_type         = "EC2" #Can start with "EC2" type for troubleshooting and then enable Load balancer later on.
  health_check_grace_period = 60
  target_group_arns         = [aws_lb_target_group.anne_lb_tg.arn]
}

resource "aws_autoscaling_policy" "anne_test_asg_up" {
  autoscaling_group_name = aws_autoscaling_group.anne_test-asg.name
  name                   = "anne-tst-asg-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "anne_test_asg_up_cpu" {
  alarm_name          = "anne-test-alarm-asg-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 60
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.anne_test_asg_up.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.anne_test-asg.name }
}

resource "aws_autoscaling_policy" "anne_test_asg_down" {
  autoscaling_group_name = aws_autoscaling_group.anne_test-asg.name
  name                   = "anne-tst-asg-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "anne_test_asg_down_cpu" {
  alarm_name          = "anne-test-alarm-asg-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.anne_test_asg_down.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.anne_test-asg.name }
}