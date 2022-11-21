terraform {
  backend "s3" {
    bucket         = "anne-tfstate-store"
    key            = "state-ec2/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}