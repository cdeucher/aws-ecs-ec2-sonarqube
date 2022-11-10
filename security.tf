resource "aws_security_group" "sonarqube_elb_sg" {
  name = "${var.app_name}-elb-sg"
  vpc_id            = data.aws_vpc.aws-vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sonarqube_db_sg" {
  name = "${var.app_name}-db-sg"
  vpc_id            = data.aws_vpc.aws-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # FIXME figure out what the correct port is
    security_groups = [aws_security_group.sonarqube_ecs_instance_sg.id]
  }
}

resource "aws_security_group" "sonarqube_ecs_instance_sg" {
  name = "${var.app_name}-ecs-instance-sg"
  vpc_id            = data.aws_vpc.aws-vpc.id
  ingress {
    from_port   = local.get_container_port
    to_port     = local.get_container_port
    protocol    = "tcp"
    security_groups = [aws_security_group.sonarqube_elb_sg.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}