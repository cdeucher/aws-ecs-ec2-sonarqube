app_name            = "nb2b-sonarqube"
vpc_id              = "vpc-XX"
public_subnets      = ["subnet-XX", "subnet-XX"]
zones               = ["us-east-1a", "us-east-1b"]
instance_type       = "t3a.xlarge"
images              = "ami-0e1ce54e679f83a66"
custom_environments = {
    CONTAINER_NAME     = "sonarqube"
    CONTAINER_PORT     = 9000
    CONTAINER_IMAGE    = "docker.io/mc1arke/sonarqube-with-community-branch-plugin"#"sonarqube:latest" #"docker.io/nginx:latest"
}
key_name            = "devops-nb2b"
rds_parameters      = [
    {name:"application_name", apply:"immediate", value: "nb2b-sonarqube-db"},
]