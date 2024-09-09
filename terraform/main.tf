provider "aws" {
  region = "us-west-2"
}

resource "aws_api_gateway_rest_api" "project_devops" {
  name        = "project_devops-api"
  description = "project_devops API"
}

resource "aws_api_gateway_resource" "project_devops" {
  rest_api_id = aws_api_gateway_rest_api.project_devops.id
  parent_id   = aws_api_gateway_rest_api.project_devops.root_resource_id
  path_part   = "project_devops"
}

resource "aws_api_gateway_method" "project_devops" {
  rest_api_id = aws_api_gateway_rest_api.project_devops.id
  resource_id = aws_api_gateway_resource.project_devops.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "project_devops" {
  rest_api_id = aws_api_gateway_rest_api.project_devops.id
  resource_id = aws_api_gateway_resource.project_devops.id
  http_method = aws_api_gateway_method.project_devops.http_method
  integration_http_method = "POST"
  type        = "LAMBDA"
  uri         = "arn:aws:apigateway:us-west-2:lambda:path/functions/arn:aws:lambda:us-west-2:123456789012:function:project_devops/invocations"
}

resource "aws_lambda_function" "project_devops" {
  filename      = "lambda_function_payload.zip"
  function_name = "project_devops"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.project_devops.arn
}

resource "aws_iam_role" "project_devops" {
  name        = "project_devops"
  description = "project_devops role"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_autoscaling_group" "project_devops" {
  name                = "project_devops-asg"
  max_size            = 10
  min_size            = 2
  desired_capacity    = 5
  health_check_type   = "EC2"
  health_check_grace_period = 300
  launch_configuration = aws_launch_configuration.project_devops
  vpc_zone_identifier  = aws_subnet.project_devops.id
}

# Crear un Load Balancer
resource "aws_elb" "project_devops" {
  name            = "project_devops-elb"
  subnets         = [aws_subnet.project_devops.id]
  security_groups = [aws_security_group.project_devops.id]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port           = 443
    lb_protocol       = "https"
  }
}

# Crear un dominio en Route 53
resource "aws_route53_zone" "project_devops" {
  name = "project_devops.com"
}

# Asociar el Load Balancer con el dominio en Route 53
resource "aws_route53_record" "project_devops" {
  zone_id = aws_route53_zone.project_devops.id
  name    = "project_devops.com"
  type    = "A"
  alias {
    name                   = aws_elb.project_devops.dns_name
    zone_id                = aws_elb.project_devops.zone_id
    evaluate_target_health = false
  }
}


