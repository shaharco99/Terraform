resource "aws_lb" "nlb" {
  name            = var.load_balancer_name
  internal        = false
  load_balancer_type = "network"
  subnets         = var.public_subnet_ids
  security_groups = ["sg-12345678"]

  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}