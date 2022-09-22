#resource "aws_vpc" "anne-test-1" {
#  cidr_block       = "10.0.0.0/16"
#  instance_tenancy = "default"
#
#  tags = {
#    Name = "anne"
#  }
#}


resource "aws_s3_bucket" "anne_test_website" {
  bucket = local.s3_bucket_name
  tags = {
    Name = "anne-website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "anne_test_website_s3_acl" {
  bucket = aws_s3_bucket.anne_test_website.id
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "anne_test_website_s3_configuration" {
  bucket = aws_s3_bucket.anne_test_website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.anne_test_website.id
  policy = data.aws_iam_policy_document.allow-public-access.json
}

resource "aws_s3_object" "anne_test_website_html" {
  for_each = fileset("../website/helloworld/", "*" )
  bucket = aws_s3_bucket.anne_test_website.id
  key    = each.value
  source = "../website/helloworld/${each.value}"
  etag = filemd5("../website/helloworld/${each.value}")
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "anne_test_website_video" {
  for_each = fileset("../website/video/", "*" )
  bucket = aws_s3_bucket.anne_test_website.id
  key    = each.value
  source = "../website/video/${each.value}"
  etag = filemd5("../website/video/${each.value}")
  acl = "public-read"
}