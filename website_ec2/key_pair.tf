resource "tls_private_key" "anne_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "anne"       # Create a "anne" to AWS!!
  public_key = tls_private_key.anne_key_pair.public_key_openssh

  provisioner "local-exec" { # Create a "anne.pem" to your computer!!
    command = "echo '${tls_private_key.anne_key_pair.private_key_pem}' > ./anne.pem"
  }
}