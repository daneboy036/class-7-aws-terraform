resource "aws_lb" "web-server-alb" {
  name               = "web-server-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id, aws_subnet.public-us-east-1c.id]

  tags = {
    Name = "Web Server ALB"
  }
}

resource "aws_lb_target_group" "web-server-alb-tg" {
  name     = "web-server-asg-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_listener" "web-server-alb-listener" {
  load_balancer_arn = aws_lb.web-server-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-server-alb-tg.arn
  }
}

resource "aws_autoscaling_attachment" "web-server-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.web-server-asg.id
  lb_target_group_arn    = aws_lb_target_group.web-server-alb-tg.arn
}
