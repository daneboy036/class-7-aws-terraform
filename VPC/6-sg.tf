resource "aws_security_group" "private-webserver-sg" {
  name        = "Private-WebServer-SG"
  description = "Private-WebServer-SG"
  vpc_id      = aws_vpc.myvpc.id

  # allow all out -- do not use the inline egress/ingress and the separate resources for it
  #   egress {
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1" # -1 means all protocols
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Private-WebServer-SG"
  }
}

# allow port 80

resource "aws_vpc_security_group_ingress_rule" "private_webserver_allow_http" {
  security_group_id = aws_security_group.private-webserver-sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}
#. using multiple cidr blocks with the same ingerss rule
# variable "ingress_cidr_blocks" {
#   type    = list(string)
#   default = ["10.0.1.0/24", "10.0.2.0/24"]
# }

# resource "aws_vpc_security_group_ingress_rule" "example_rule" {
#   for_each = toset(var.ingress_cidr_blocks)

#   security_group_id = aws_security_group.example.id
#   cidr_ipv4         = each.key
#   from_port         = 80
#   to_port           = 80
#   ip_protocol       = "tcp"
#   description       = "Allow TCP traffic from CIDR block ${each.key}"
# }

# allow all outbound
resource "aws_vpc_security_group_egress_rule" "private_webserver_allow_all_outbound" {
  security_group_id = aws_security_group.private-webserver-sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
  # if you want to use "-1" for protocol then ommit from_port and to_port
}

resource "aws_security_group" "alb_sg" {
  name        = "ALB-SG"
  description = "ALB-SG"
  vpc_id      = aws_vpc.myvpc.id
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "ALB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_http" {
  security_group_id = aws_security_group.alb_sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_allow_all_outbound" {
  security_group_id = aws_security_group.alb_sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_security_group" "public-webserver-sg" {
  name        = "Public-WebServer-SG"
  description = "Public-WebServer-SG"
  vpc_id      = aws_vpc.myvpc.id

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Public-WebServer-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_webserver_allow_ssh" {
  security_group_id = aws_security_group.public-webserver-sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
}


resource "aws_vpc_security_group_ingress_rule" "public_webserver_allow_http" {
  security_group_id = aws_security_group.public-webserver-sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "public_webserver_allow_all_outbound" {
  security_group_id = aws_security_group.public-webserver-sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
