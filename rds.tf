resource "aws_db_instance" "sonarqube" {
  identifier          = "${var.app_name}-db-instance"
  allocated_storage   = 64
  engine              = "postgres"
  engine_version      = "14.1"
  storage_type        = "standard"
  instance_class      = "db.t3.micro"
  skip_final_snapshot = "true" # FIXME

  vpc_security_group_ids = [aws_security_group.sonarqube_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  db_name     = "sonar"
  username = "sonarqube"
  password = "sonarqube"

  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
  depends_on = [aws_db_parameter_group.db_parameter_group]
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.app_name}-db-parameter-group-rds"
  family      = "postgres14"
  description = "DB Parameter Group for RDS"

  dynamic "parameter" {
    for_each = var.rds_parameters
    content {
      apply_method   = parameter.value.apply
      name           = parameter.value.name
      value          = parameter.value.value
    }
  }
  tags = {
    Name        = "${var.app_name}-subnet-group-rds"
  }
  lifecycle {
    ignore_changes = [description,tags]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.app_name}-subnet-group-rds"
  subnet_ids  = var.public_subnets
  description = "DB Subnet Group for RDS"

  tags = {
    Name        = "${var.app_name}-subnet-group-rds"
  }
  lifecycle {
    ignore_changes = [description,tags]
  }
}