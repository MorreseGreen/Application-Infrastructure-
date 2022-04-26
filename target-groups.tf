resource "aws_lb_target_group" "blue_target" {
  name     = "blue-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "green_target" {
  name     = "green-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}