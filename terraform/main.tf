#
provider "aws" {
  region = "tu_region_aws"
}

resource "aws_ecs_cluster" "grafana_cluster" {
  name = "grafana-cluster"
}

resource "aws_ecs_task_definition" "grafana_task" {
  // Define tu tarea ECS para Grafana
}

resource "aws_ecs_service" "grafana_service" {
  // Define tu servicio ECS para Grafana
}
