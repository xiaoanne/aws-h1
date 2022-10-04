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

variable "key_name" {
  default = "anne"
}

variable "ingress_rules" {
    type        = map(object(
      {
        from = number
        to = number
        proto = string
        cidr = string
        desc = string
      }
    ))
    default     = {
        thing1 = {from=23, to=22, proto="tcp", cidr="0.0.0.0/0", desc="anne"},
        thing2 = {from=80, to=23, proto="tcp", cidr="0.0.0.0/0", desc="anne"},
        thing2 = {from=443, to=443, proto="tcp", cidr="0.0.0.0/0", desc="anne"},
    }
}