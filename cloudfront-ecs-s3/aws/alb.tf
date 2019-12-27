resource "aws_lb_target_group" "webapp" {
  port = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.app-vpc.id
  health_check {
    enabled = true
    path = "/healthcheck"
  }
  depends_on = [aws_alb.webapp]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb" "webapp" {
  name = "webapp"
  internal = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.eu-west-2a-public.id,
    aws_subnet.eu-west-2b-public.id
  ]
  security_groups = [
    aws_security_group.http.id,
    aws_security_group.https.id,
    aws_security_group.egress-all.id,
  ]
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_alb_listener" "webapp" {
  load_balancer_arn = aws_alb.webapp.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}

output "alb_url" {
  value = "http://${aws_alb.webapp.dns_name}"
}
