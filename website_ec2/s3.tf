#create s3 bucket so the EC2 instance can download html files and related images and videos.

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

resource "aws_s3_bucket_public_access_block" "anne_test_website_block_public_Access" {
  bucket = aws_s3_bucket.anne_test_website.id
  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = true
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

#Upload the photo and video being used by the website. Comment out etag as s3 bucket denies as terrafrom think anne.mp4 is a new video.
resource "aws_s3_object" "anne_test_website_video" {
  for_each = fileset("../website/video/", "*")
  bucket   = aws_s3_bucket.anne_test_website.id
  key      = each.value
  source   = "../website/video/${each.value}"
#  etag     = filemd5("../website/video/${each.value}")
  acl      = "public-read"
}