resource "tls_private_key" "anne_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "anne" # Create a "anne" key pair to AWS key pair!!
  public_key = tls_private_key.anne_key_pair.public_key_openssh

  # Please be aware of when you first create the key value pair, there will be no anne.pem file to be deleted so error will appear, just comment out the next 2 lines.
  provisioner "local-exec" { # Terraform doesn't delete anne.pem with terraform destory, and terraform apply doesn't auto replace the old pem file, therefore deleted forcely.
    command = "rm ./anne.pem"
  }

  provisioner "local-exec" { # Create a "anne.pem" to your computer!!
    command = "echo '${tls_private_key.anne_key_pair.private_key_pem}' > ./anne.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 anne.pem"
  }
}