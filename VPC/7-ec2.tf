resource "aws_instance" "my-web-server" {
  ami                         = "ami-0bdd88bd06d16ba03"
  instance_type               = "t3.micro"
  security_groups             = [aws_security_group.public-webserver-sg.id]
  subnet_id                   = aws_subnet.public-us-east-1a.id
  associate_public_ip_address = true
  key_name                    = "BMC7-General"

  user_data = file("user_data.sh")

  # count = 0 # disable
  tags = {
    Name = "WebServer"
  }
}

resource "aws_launch_template" "web-server-lt" {
  name_prefix = "web-server-template-"
  description = "Launch Template for Launch HTTP Servers"

  image_id      = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
  key_name      = "BMC7-General"

  # don't include network settings since we'll use an ASG

  vpc_security_group_ids = [aws_security_group.private-webserver-sg.id]

  user_data = filebase64("user_data.sh")
  tags = {
    Name = "WebServer Launch Template"
  }
}

resource "aws_autoscaling_group" "web-server-asg" {
  vpc_zone_identifier = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  desired_capacity    = 2
  min_size            = 1
  max_size            = 2

  launch_template {
    id      = aws_launch_template.web-server-lt.id
    version = "$Latest"
  }
}
