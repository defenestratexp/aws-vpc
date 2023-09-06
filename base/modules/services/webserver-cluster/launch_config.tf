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