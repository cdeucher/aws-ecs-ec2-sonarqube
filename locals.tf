locals {
  common_vars = {
    ENDPOINT = aws_db_instance.sonarqube.endpoint
    LOG_GROUP_ID       = aws_cloudwatch_log_group.log-group.id
    AWS_REGION         = var.region
    APP_NAME           = var.app_name
  }
  get_container_port = var.custom_environments["CONTAINER_PORT"]
  get_container_name = var.custom_environments["CONTAINER_NAME"]
}