resource "aws_lb" "application_lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer_sg.id]
  subnets            = [data.aws_subnet.public-a.id, data.aws_subnet.public-b.id]

  tags = {
    Name = "application-lb"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.blue_target.arn
      }

      target_group {
        arn = aws_lb_target_group.green_target.arn
      }
    }
  }
}

resource "aws_elb" "lb" {
  name               = "application-lb"
  availability_zones = ["us-east-1a"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_lb_cookie_stickiness_policy" "application_infrastructure" {
  name                     = "application-lb"
  load_balancer            = aws_elb.lb.id
  lb_port                  = 80
  cookie_expiration_period = 1
}