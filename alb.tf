resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-alb"
  internal           = false
  enable_deletion_protection = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.sonarqube_elb_sg.id]
  drop_invalid_header_fields = true

  tags = {
    Name        = "${var.app_name}-alb"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.app_name}-tg"
  port        = local.get_container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.aws-vpc.id
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
  tags = {
    name        = "${var.app_name}-tg"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
  depends_on = [aws_lb_target_group.target_group, aws_alb.application_load_balancer]
}