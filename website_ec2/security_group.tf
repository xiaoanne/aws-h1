resource "aws_security_group" "allow_web" {
  name        = "anne_allow_ssh"
  description = "Allow ssh traffic"
  vpc_id      = aws_vpc.anne_test_website_vpc.id

  #  ingress {
  #    description = "Allow ssh from VPC"
  #    from_port   = 22
  #    to_port     = 22
  #    protocol    = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }
  #
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description = "Web Traffic from internet"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  #  dynamic "egress" {
  #    for_each = toset(local.ports_out)
  #    content {
  #      description = "Web Traffic to internet"
  #      from_port   = egress.value
  #      to_port     = egress.value
  #      protocol    = "-1"
  #      cidr_blocks = ["0.0.0.0/0"]
  #    }
  #  }

  tags = {
    Name = "anne"
  }
}


#resource "aws_security_group_rule" "ingress_rules" {
#  for_each          = var.ingress_rules
#  type              = "ingress"
#  from_port         = each.value.from
#  to_port           = each.value.to
#  protocol          = each.value.proto
#  cidr_blocks       = [each.value.cidr]
#  description       = each.value.desc
#  security_group_id = aws_security_group.allow_web.id
#}

#resource "aws_security_group_rule" "egress_rules" {
#  type              = "egress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = -1
#  cidr_blocks = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.allow_web.id
#}