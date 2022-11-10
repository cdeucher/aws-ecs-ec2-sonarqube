resource "aws_iam_instance_profile" "sonarqube_ecs_host" {
  name = "${var.app_name}-ecs-host-profile"
  role = aws_iam_role.sonarqube_ecs.name
}

# AmazonEC2ContainerServiceforEC2Role
resource "aws_iam_role" "sonarqube_ecs" {

  name = "${var.app_name}-ecs-role"

  assume_role_policy = <<ROLE
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs.amazonaws.com", "ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
ROLE
}

resource "aws_iam_role_policy_attachment" "sonarqube_ecs_service" {
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role        = aws_iam_role.sonarqube_ecs.name
}

resource "aws_iam_role_policy_attachment" "sonarqube_ecs_elb" {
  role        = aws_iam_role.sonarqube_ecs.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}