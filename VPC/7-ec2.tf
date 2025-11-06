resource "aws_instance" "my-web-server" {
  ami                         = "ami-0bdd88bd06d16ba03"
  instance_type               = "t3.micro"
  security_groups             = [aws_security_group.app1-sg-servers.id]
  subnet_id                   = aws_subnet.public-us-east-1a.id
  associate_public_ip_address = true
  key_name                    = "BMC7-General"

  user_data = file("user_data.sh")

  tags = {
    Name = "WebServer"
  }
}
