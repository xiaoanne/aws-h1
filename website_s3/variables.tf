variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "s3_bucket" {
  type    = string
  default = "anne_test_website"
}

variable "id" {
  type    = string
  default = "064782962204"
}

variable "tf_version" {
  type    = string
  default = ">= 1.2.0"
}

variable "aws_version" {
  type = string
  default = "~> 4.16"
}

