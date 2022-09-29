# This .tf file is used to create the s3 bucket and its policy as required.

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
    Name        = "anne-website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "anne_test_website_s3_acl" {
  bucket = aws_s3_bucket.anne_test_website.id
  acl    = "private"
}

# When block the public website, the website hosted by AWS won't be available anymore, but the Cloudfront Domain name should still serve.
# In my case, when not having the aws_s3_bucket_public_access_block block, both URL will serve including:
# http://anne-test-website.s3-website-ap-southeast-2.amazonaws.com/ and https://d2mdotld4x2t9s.cloudfront.net/
# After having the following block, only the later URL provided by cloudfront will be available. The former one won't work.
# However it also means there is no access to upload the s3 object to the s3 bucket. Therefore I comment this block out. And now both URL should work.

#resource "aws_s3_bucket_public_access_block" "anne_test_website_block_public_Access" {
#  bucket = aws_s3_bucket.anne_test_website.id
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

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
  policy = data.aws_iam_policy_document.allow_cloudfront_access.json
}

#Upload the index and error html files.
resource "aws_s3_object" "anne_test_website_html" {
  for_each     = fileset("../website/helloworld/", "*")
  bucket       = aws_s3_bucket.anne_test_website.id
  key          = each.value
  source       = "../website/helloworld/${each.value}"
  etag         = filemd5("../website/helloworld/${each.value}")
  acl          = "public-read"
  content_type = "text/html"
}

#Upload the photo and video being used by the website.
resource "aws_s3_object" "anne_test_website_video" {
  for_each = fileset("../website/video/", "*")
  bucket   = aws_s3_bucket.anne_test_website.id
  key      = each.value
  source   = "../website/video/${each.value}"
  etag     = filemd5("../website/video/${each.value}")
  acl      = "public-read"
}