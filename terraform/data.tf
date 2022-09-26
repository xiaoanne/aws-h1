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


data "aws_iam_policy_document" "allow_cloudfront_access" {
  statement {
    sid = "AllowCloudFrontServicePrincipalReadOnly"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
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

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:cloudfront::064782962204:distribution/E2V3M9OAMMOFL3"]
    }
  }
}