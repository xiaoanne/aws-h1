resource "aws_instance" "anne_test_website_ec2" {
  count                       = length(local.private_subnet)
  ami                         = local.ec2_ami
  instance_type               = local.ec2_type
  security_groups             = [aws_security_group.allow_web.id]
  subnet_id                   = aws_subnet.private[count.index].id
  key_name                    = "anne"
  associate_public_ip_address = true

  tags = {
    Name = "anne"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo service httpd start",
      "sudo service httpd status",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("./anne.pem")
    timeout     = "4m"
  }
}