# Example web server cluster in an auto-scaling group

# Launch configuration describes how to configure each instance in an ASG
resource "aws_launch_configuration" "webserver_cluster_launch" {
  image_id        = "ami-0fb653ca2d3203ac1"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webserver_cluster_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Healtn9nucks" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF

  # Required when using a launch config with an ASG
  lifecycle {
    create_before_destroy = true
  }
}

# Create the ASG with the launch configuration
resource "aws_autoscaling_group" "webserver_cluster_asg" {
  launch_configuration = aws_launch_configuration.webserver_cluster_launch.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  # Dynamically attach target group
  target_group_arns = [aws_lb_target_group.webserver_cluster_targets.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "tf-asg-example"
    propagate_at_launch = true
  }
}

# Data source - VPC
data "aws_vpc" "default" {
  default = true
}

# Data source. In this example it is to obtain the default VPC ID
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# A load-balancer in front of the group will distribute traffic
# First create an application load-balancer
resource "aws_lb" "webserver_cluster_lb" {
  name               = "webserver-cluster-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.webserver_cluster_sg.id]
}

# Define a listener for the load balancer
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

# A security group to allow traffic to and from the load balancer
resource "aws_security_group" "webserver_cluster_sg" {
  name = "webserver-cluster-alb"

  # Inboud rules
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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