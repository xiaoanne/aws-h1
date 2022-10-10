data "aws_availability_zones" "available" {
  state = "available"
}

#data "cloudinit_config" "foo" {
#  gzip = false
#  base64_encode = false
#
#  part {
#    content_type = "text/x-shellscript"
#    content = "baz"
#    filename = "web.conf"
#  }
#}