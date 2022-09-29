# The IAM policy "allow-public-access" is used in the scenario where only S3 bucket being used to host the website therefore it needs to be accessible by public.
#data "aws_iam_policy_document" "allow-public-access" {
#  statement {
#    principals {
#      identifiers = [var.id]
#      type        = "AWS"
#    }
#
#    actions = [
#      "s3:Get*",
#      "s3:List*",
#      "s3:Put*",
#    ]
#
#    resources = [
#        "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}",
#        "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}/*",
#    ]
#  }
#}


#Currently there are still 2 statements being used one for public access under this AWS account, one for AWS cloudfront permission, maybe it needs refactor later.
data "aws_iam_policy_document" "allow_cloudfront_access" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E3S9OUOP6780ZZ"]
    }

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}",
      "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}/*",
    ]
  }

#  statement {
#    effect = "Allow"
#    principals {
#      identifiers = [var.id]
#      type        = "AWS"
#    }
#
#    actions = [
#      "s3:Get*",
#      "s3:List*",
#      "s3:Put*",
#    ]
#
#    resources = [
#      "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}",
#      "arn:aws:s3:::${aws_s3_bucket.anne_test_website.id}/*",
#    ]
#  }
}