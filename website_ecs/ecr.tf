#resource "aws_ecr_repository" "anne_test_website" {
#  name                 = "anne-test-website"
#  image_tag_mutability = "MUTABLE"
#
#  image_scanning_configuration {
#    scan_on_push = true
#  }
#
#  tags = local.tags
#}