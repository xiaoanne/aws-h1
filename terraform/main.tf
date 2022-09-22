terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region
}

#resource "aws_vpc" "anne-test-1" {
#  cidr_block       = "10.0.0.0/16"
#  instance_tenancy = "default"
#
#  tags = {
#    Name = "anne"
#  }
#}


resource "aws_s3_bucket" "anne-test-website" {
  bucket = var.s3_bucket
  tags = {
    Name = "anne-website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "anne-test-website-s3-acl" {
  bucket = aws_s3_bucket.anne-test-website.id
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "anne-test-website-s3-configuration" {
  bucket = aws_s3_bucket.anne-test-website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "allow-public-access" {
  bucket = aws_s3_bucket.anne-test-website.id
  policy = data.aws_iam_policy_document.allow-public-access.json
}

data "aws_iam_policy_document" "allow-public-access" {
  statement {
    principals {
      identifiers = [var.id]
      type        = "AWS"
    }

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]

    resources = [
        "arn:aws:s3:::${aws_s3_bucket.anne-test-website.id}",
        "arn:aws:s3:::${aws_s3_bucket.anne-test-website.id}/*",
    ]
  }
}

resource "aws_s3_object" "anne-test-website-html" {
  for_each = fileset("../website/helloworld/", "*" )
  bucket = aws_s3_bucket.anne-test-website.id
  key    = each.value
  source = "../website/helloworld/${each.value}"
  etag = filemd5("../website/helloworld/${each.value}")
  acl = "public-read"
}