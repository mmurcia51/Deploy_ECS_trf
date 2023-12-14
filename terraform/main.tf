provider "aws" {
  region = "tu_region_aws"
}

resource "aws_ecs_cluster" "grafana_cluster" {
  name = "grafana-cluster"
}

resource "aws_ecs_task_definition" "grafana_task" {
  family                   = "grafana-task-family"
  network_mode             = "awsvpc"  # O el modo de red que desees
  requires_compatibilities = ["FARGATE"]  # O ["EC2"] dependiendo de tus necesidades

  execution_role_arn = module.ecs.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "grafana-container"
      image = "mmurcia57/grafana-app:latest"  # Ajusta la imagen según tu necesidad
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
    // Puedes agregar más definiciones de contenedores si es necesario
  ])
}

module "ecs" {
  source = "./ecs"  # Ajusta la ruta al directorio o módulo de ECS
}

resource "aws_ecs_service" "grafana_service" {
  name            = "grafana-service"
  cluster         = aws_ecs_cluster.grafana_cluster.id
  task_definition = aws_ecs_task_definition.grafana_task.arn
  launch_type     = "FARGATE"  # O "EC2" dependiendo de tus necesidades

  network_configuration {
    subnets = module.ecs.subnets
    security_groups = module.ecs.security_groups
  }

  // Puedes agregar más configuraciones según tus necesidades
}
