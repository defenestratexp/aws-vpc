# Autoscaling group for the cluster
# Launch configuration is defined in launch_config.tf
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