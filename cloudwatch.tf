resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.app_name}-logs"
  retention_in_days = 7

  tags = {
    Name        = "${var.app_name}-logs"
    Application = var.app_name
  }
  lifecycle {
    ignore_changes = [tags]
  }
}