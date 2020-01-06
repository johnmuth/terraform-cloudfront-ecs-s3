resource "aws_ecs_cluster" "webapp" {
  name = var.webapp_id
}

resource "aws_ecs_service" "webapp" {
  name = var.webapp_id
  task_definition = aws_ecs_task_definition.webapp.arn
  cluster = aws_ecs_cluster.webapp.id
  launch_type = "FARGATE"
  desired_count = 1
  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.egress-all.id,
      aws_security_group.api-ingress.id,
    ]
    subnets = [
      aws_subnet.eu-west-2a-private.id,
      aws_subnet.eu-west-2b-private.id
    ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.webapp.arn
    container_name = var.webapp_id
    container_port = "3000"
  }
}

resource "aws_iam_role" "webapp-task-execution-role" {
  name = "webapp-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-task-assume-role.json
}

data "aws_iam_policy_document" "ecs-task-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ecs-task-execution-role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role" {
  role = aws_iam_role.webapp-task-execution-role.name
  policy_arn = data.aws_iam_policy.ecs-task-execution-role.arn
}

resource "aws_cloudwatch_log_group" "webapp" {
  name = "/ecs/${var.webapp_id}"
}

resource "aws_ecs_task_definition" "webapp" {
  family = var.webapp_id
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.webapp-task-execution-role.arn
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = <<DEFINITIONS
[
  {
    "name": "${var.webapp_id}",
    "image": "${aws_ecr_repository.webapp.repository_url}",
    "essential": true,
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "environment": [
      {
        "name": "PORT",
        "value": "3000"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.webapp.name}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITIONS
}
