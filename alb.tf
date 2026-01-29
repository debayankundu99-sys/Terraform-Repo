resource "aws_lb" "alb" {
  name = "app-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web_sg.id]
  subnets = [aws_subnet.public_az_a.id,aws_subnet.public_az_b.id]
  
}

resource "aws_lb_target_group" "tg" {
  name = "app-tg-1"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.debayanvpc.id
}


resource "aws_lb_target_group_attachment" "app_attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.app.id
  port = 8080
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"


  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
