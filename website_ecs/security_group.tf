resource "aws_security_group" "load_balancer_security_group-1" {
  name        = "allow_http-1"
  description = "Allow ssh and http traffic"
  vpc_id      = aws_vpc.anne_test_website_vpc.id

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

  tags = local.tags
}

resource "aws_security_group" "load_balancer_security_group" {
  name        = "allow_http"
  description = "Allow ssh and http traffic"
  vpc_id      = aws_vpc.anne_test_website_vpc.id

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

  tags = local.tags
}


#resource "aws_security_group" "service_security_group" {
#  vpc_id = aws_vpc.anne_test_website_vpc.id
#  ingress {
#    from_port = 0
#    to_port   = 0
#    protocol  = "-1"
#    # Only allowing traffic in from the load balancer security group
#    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = local.tags
#}