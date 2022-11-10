resource "aws_ecs_cluster" "sonarqube" {
  name = "${var.app_name}-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}