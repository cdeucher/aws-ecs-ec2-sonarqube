resource "aws_launch_configuration" "sonarqube_ecs_nodes" {
  name_prefix   = "${var.app_name}-ecs-cluster-"
  image_id      = var.images
  instance_type = var.instance_type
  key_name      = var.key_name
  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile = aws_iam_instance_profile.sonarqube_ecs_host.name

  security_groups = [aws_security_group.sonarqube_ecs_instance_sg.id]
  user_data     = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.sonarqube.name} >> /etc/ecs/ecs.config
echo 'vm.max_map_count = 262144' >> /etc/sysctl.conf
sysctl -p
EOF

  depends_on = [aws_security_group.sonarqube_ecs_instance_sg]
}