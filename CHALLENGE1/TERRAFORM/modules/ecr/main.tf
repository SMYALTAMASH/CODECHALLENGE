resource "aws_ecs_cluster" "ops" {
  name = "default"
}

resource "aws_ecs_service" "default" {
  count = "${var.enabled}"
  name = "${var.name}"
  task_definition = "${aws_ecs_task_definition.default.arn}"
  cluster = "${aws_ecs_cluster.ops.arn}"
  desired_count = "${var.desired_count}"
  deployment_maximum_percent = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_controller {
    type = "${var.deployment_controller_type}"
  }
  network_configuration {
    subnets         = ["${var.subnets}"]
    security_groups = ["${aws_security_group.default.id}"]
    assign_public_ip = "${var.assign_public_ip}"
  }
  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name = "${var.container_name}"
    container_port = "${var.container_port}"
  }
  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"
  launch_type = "FARGATE"
  scheduling_strategy = "REPLICA"
  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
resource "aws_security_group" "default" {
  #count = "${var.enabled}"
  name   = "${local.security_group_name}"
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(map("Name", local.security_group_name), var.tags)}"
}
locals {
  security_group_name = "${var.name}-ecs-fargate"
}
resource "aws_security_group_rule" "ingress" {
  count = "${var.enabled}"
  type              = "ingress"
  from_port         = "${var.container_port}"
  to_port           = "${var.container_port}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.ingress_cidr_blocks}"]
  security_group_id = "${aws_security_group.default.id}"
}
resource "aws_security_group_rule" "egress" {
  count = "${var.enabled}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.default.id}"
}
resource "aws_ecs_task_definition" "default" {
  count = "${var.enabled}"
  family = "${var.name}"
  execution_role_arn = "${var.ecs_task_execution_role_arn}"
  #execution_role_arn = "${var.create_ecs_task_execution_role ? join("", aws_iam_role.default.*.arn) : var.ecs_task_execution_role_arn}"
  container_definitions = "${var.container_definitions}"
  cpu = "${var.cpu}"
  memory = "${var.memory}"
  requires_compatibilities = ["${var.requires_compatibilities}"]
  network_mode = "awsvpc"
  tags = "${merge(map("Name", var.name), var.tags)}"
}
