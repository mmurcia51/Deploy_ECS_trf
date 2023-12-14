provider "aws" {
  access_key = "AKIA6CY4IDLETEVNMFW4"
  secret_key = "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" 
  region = "us-east-1"
}

resource "aws_ecs_cluster" "grafana_cluster" {
  name = "grafana-cluster"
}

resource "aws_ecs_task_definition" "grafana_task" {
  family                   = "grafana-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  // Asegúrate de proporcionar el ARN del rol de ejecución directamente si no estás utilizando un módulo
  execution_role_arn = "arn:aws:iam::123456789012:role/your_execution_role"

  container_definitions = jsonencode([
    {
      name  = "grafana-container"
      image = "mmurcia57/grafana-app:latest"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "grafana_service" {
  name            = "grafana-service"
  cluster         = aws_ecs_cluster.grafana_cluster.id
  task_definition = aws_ecs_task_definition.grafana_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    // Asegúrate de proporcionar las subnets y security groups directamente si no estás utilizando un módulo
    subnets        = ["subnet-12345678", "subnet-87654321"]
    security_groups = ["sg-0123456789abcdef0"]
  }
}
