# There are 2 ways of connecting and running commands/uploading files to the EC2 instance. One is using the provisioner file/remote-exec, the second one is using the cloud-init user data. Here we used the second option.

resource "aws_instance" "anne_test_website_ec2" {
  count                       = length(local.private_subnet)
  ami                         = local.ec2_ami
  instance_type               = local.ec2_type
  security_groups             = [aws_security_group.allow_web.id]
  subnet_id                   = aws_subnet.private[count.index].id
  user_data                   = file("web.conf")
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = true

  tags = {
    Name = "anne"
  }

  #  provisioner "local-exec" {
  #    command = "chmod 400 anne.pem"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "mkdir /tmp/html",
  #      "sudo yum install httpd -y",
  #      "sudo service httpd start",
  #      "sudo service httpd status",
  #    ]
  #  }

  #  provisioner "file" {
  #    source      = "../website/helloworld/index.html"
  #    destination = "/tmp/html/index.html"
  #  }
  #
  #  provisioner "file" {
  #    source      = "../website/video/"
  #    destination = "/tmp/html"
  #  }

  #  provisioner "remote-exec" {
  #    inline = [
  #      "sudo mv /tmp/html/* /var/www/html",
  #      "ls /var/www/html",
  #    ]
  #  }
  #
  #  connection {
  #    type        = "ssh"
  #    host        = self.public_ip
  #    user        = "ec2-user"
  #    private_key = file("./anne.pem")
  #    timeout     = "4m"
  #  }
}