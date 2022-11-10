data "template_file" "task_definition" {
  template = file("templates/task_definition.json")
  vars     = merge(var.custom_environments, local.common_vars)
}

resource "aws_ecs_task_definition" "sonarqube_web" {
  family                = "${var.app_name}-task-definition"
  network_mode          = "awsvpc"
  container_definitions = data.template_file.task_definition.rendered
  depends_on = [aws_db_instance.sonarqube]
}

resource "aws_ecs_service" "sonarqube" {
  name            = "${var.app_name}-ecs-service"
  task_definition = "${aws_ecs_task_definition.sonarqube_web.family}:${max(aws_ecs_task_definition.sonarqube_web.revision, data.aws_ecs_task_definition.main.revision)}"
  cluster         = aws_ecs_cluster.sonarqube.id
  desired_count   = 1

  network_configuration {
    subnets          = var.public_subnets
    assign_public_ip = false
    security_groups = [
      aws_security_group.sonarqube_ecs_instance_sg.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name = local.get_container_name
    container_port = local.get_container_port
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.sonarqube_web.family
}