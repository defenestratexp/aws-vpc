# Load-balancer resources
# subnets comes from data.tf
# security_groups comes from security_groups.tf

resource "aws_lb" "webserver_cluster_lb" {
  name               = "webserver-cluster-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.webserver_cluster_sg.id]
}

# The load-balancer requires a listener
resource "aws_lb_listener" "webserver_cluster_listener" {
  load_balancer_arn = aws_lb.webserver_cluster_lb.arn
  port              = var.server_port
  protocol          = "HTTP"

  # Create a 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# Target group for auto-scaling
resource "aws_lb_target_group" "webserver_cluster_targets" {
  name     = "webserver-cluster-targets"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Listener rule
resource "aws_lb_listener_rule" "webserver_cluster_rule" {
  listener_arn = aws_lb_listener.webserver_cluster_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_cluster_targets.arn
  }
}