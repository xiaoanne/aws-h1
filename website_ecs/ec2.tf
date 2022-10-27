#resource "aws_instance" "anne_test_website_ec2" {
#  ami                         = local.ec2_ami
#  instance_type               = local.ec2_type
#  security_groups             = [aws_security_group.load_balancer_security_group.id]
#  subnet_id                   = aws_subnet.private_1.id
##  user_data                   = file("web.conf")
#  key_name                    = aws_key_pair.kp.key_name
#  associate_public_ip_address = true
#
#
#  tags = {
#    Name = "anne-1"
#  }
#}