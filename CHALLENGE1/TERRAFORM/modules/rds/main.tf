resource "aws_db_subnet_group" "subnet_group" {
  name                    = "${var.rds_name}"
  description             = "${var.rds_name} RDS subnet group"
  subnet_ids              = ["${var.subnets}"]
}

resource "aws_db_parameter_group" "default" {
    name = "${var.db_parameter_group}"
    family = "${var.db_parameter_group_family}"

    parameter {
      name = "character_set_server"
      value = "utf8"
    }

    parameter {
      name = "character_set_client"
      value = "utf8"
    }
}

resource "aws_db_instance" "instance" {
  name                    = "${var.rds_name}"
  identifier              = "${var.rds_name}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  allocated_storage       = "${var.allocated_storage}"
  storage_type            = "${var.rds_storage_type}"
  iops                    = "${var.iops}"
  instance_class          = "${var.instance_class}"
  username                = "${var.username}"
  password                = "${var.password}"
  vpc_security_group_ids  = ["${var.sgs}"]
  db_subnet_group_name    = "${aws_db_subnet_group.subnet_group.id}"
  parameter_group_name    = "${var.db_parameter_group}"
  multi_az                = "${var.multi_az}"
  backup_retention_period = 1
  backup_window           = "16:00-16:30"
  apply_immediately       = true
}


