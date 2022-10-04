resource "aws_instance" "anne_test_website_ec2" {
  count           = length(local.private_subnet)
  ami             = local.ec2_ami
  instance_type   = local.ec2_type
  security_groups = [aws_security_group.allow_web.id]
  subnet_id       = aws_subnet.private[count.index].id
  key_name        = "anne"
  associate_public_ip_address = true

  tags = {
    Name = "anne"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("anne.pem")
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo su",
      "yum update -y",
      "yum install httpd -y",
      "service httpd start"
    ]
  }
}