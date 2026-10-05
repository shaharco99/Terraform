resource "aws_lb" "nlb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids
  security_groups    = var.security_group_ids

  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}