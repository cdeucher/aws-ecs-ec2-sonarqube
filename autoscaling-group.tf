resource "aws_autoscaling_group" "sonarqube_cluster" {
  name = "${var.app_name}-asg"
  vpc_zone_identifier = var.public_subnets
  max_size         = 1
  min_size         = 1
  desired_capacity = 1
  launch_configuration = aws_launch_configuration.sonarqube_ecs_nodes.name
  health_check_type   = "EC2"
}