
output "db_endpoint" {
  value = aws_db_instance.sonarqube.endpoint
}

output "elb_dns" {
  value = aws_alb.application_load_balancer.dns_name
}