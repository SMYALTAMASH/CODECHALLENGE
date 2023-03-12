# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
  version = "v2.70.0"
}

#######################
#### Network Setup ####
#######################

module "vpc" {
  source                  = "../modules/vpc"
  vpc_cidr                = "${var.vpc_cidr}"
  env                     = "${var.env}"
  subnet_public_count     = "${var.subnet_public_count}"
  public_cidr             = "${var.public_cidr}"
  public_subnet_name      = "${var.public_subnet_name}-${var.env}"
  subnet_public_count_1B  = "${var.subnet_public_count_1B}"
  public_cidr_1B          = "${var.public_cidr_1B}"
  public_subnet_name_1B   = "${var.public_subnet_name_1B}"
  subnet_private_count    = "${var.subnet_private_count}"
  private_cidr            = "${var.private_cidr}"
  private_subnet_name     = "${var.private_subnet_name}-${var.env}"
  subnet_private_count_1B = "${var.subnet_private_count_1B}"
  private_cidr_1B         = "${var.private_cidr_1B}"
  private_subnet_name_1B  = "${var.private_subnet_name_1B}"
}

module "route" {
  source                = "../modules/vpc/route_tables"
  main                  = "${module.vpc.id}"
  igw                   = "${module.vpc.igw}"
  nat-gw                = "${module.vpc.nat-gw}"
  pub_subnet_ids        = "${module.vpc.public_ids}"
  pri_subnet_ids        = "${module.vpc.private_ids}"
  pub_count             = "${var.subnet_public_count}"
  pri_count             = "${var.subnet_private_count}"
}

###################################
#### ROle and policy Update #######
###################################

module "iam" {
  source = "../modules/iam"

  name = "ecs-task-execution-for-ecs-fargate"
}

################################
#### ECS Service Deployment ####
################################

module "ecs" {
  source                = "../modules/ecr"
  name                  = "ops"
  #cluster               = "${aws_ecs_cluster.ops.arn}"
  container_name        = "${local.container_name}"
  container_port        = "${local.container_port}"
  subnets               = ["${module.vpc.public_ids}"]
  target_group_arn      = "${module.alb.alb_target_group_arn}"
  vpc_id                = "${module.vpc.id}"
  container_definitions = "${data.template_file.default.rendered}"

  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  deployment_controller_type         = "ECS"
  assign_public_ip                   = true
  health_check_grace_period_seconds  = 10
  ingress_cidr_blocks                = ["0.0.0.0/0"]
  cpu                                = 256
  memory                             = 512
  requires_compatibilities           = ["FARGATE"]
  ecs_task_execution_role_arn    = "${module.iam.iam_role_arn}"

  tags = {
    Environment = "${var.env}"
  }
}

data "template_file" "default" {
  template = "${file("${path.module}/container_definitions.json")}"

  vars {
    container_name = "${local.container_name}"
    container_port = "${local.container_port}"
  }
}

locals {
  container_name = "ops"
  container_port = "${module.alb.alb_target_group_port}"
}

#resource "aws_ecs_cluster" "ops" {
#  name = "default"
#}

###################
#### ALB Setup ####
###################

module "alb" {
  source                     = "../modules/alb"
  name                       = "ecs-fargate"
  vpc_id                     = "${module.vpc.id}"
  subnets                    = ["${module.vpc.public_ids}", "${module.vpc.public_ids_1B}"]
  access_logs_bucket         = "${module.s3_lb_log.s3_bucket_id}"
  enable_https_listener      = false
  enable_http_listener       = true
  enable_deletion_protection = false
}

module "s3_lb_log" {
  source                = "../modules/s3_lb_log"
  name                  = "s3-lb-log-ecs-fargate-${data.aws_caller_identity.current.account_id}"
  logging_target_bucket = "${module.s3_access_log.s3_bucket_id}"
  force_destroy         = true
}

module "s3_access_log" {
  source        = "../modules/s3_access_log"
  name          = "s3-access-log-ecs-fargate-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}


data "aws_caller_identity" "current" {}

##########################
#### Cloudfront Setup ####
##########################

module "cloudfront" {
  source        = "../modules/cloud_front"
  aws_alb       = "${module.alb.alb_dns_name}"
  origin        = "alb-app"
  env           = "${var.env}"
  min_ttl       = 0
  default_ttl   = 300
  max_ttl       = 31536000
}

###################
#### RDS Setup ####
###################

module "rds_sg" {
  source                = "../modules/sg/rds"
  vpc_id                = "${module.vpc.id}"
  port_mysql            = "${var.port_mysql}"
  sg_id                 = "${module.ecs.sg_id}"
}

module "rds" {
  source              = "../modules/rds"
  rds_name            = "${var.environment}db"
  engine              = "mysql"
  engine_version      = "5.7"
  allocated_storage   = "30"
  rds_storage_type    = "gp2"
  instance_class      = "db.t2.micro"
  multi_az	      = "false"
  username            = "${var.database_username}"
  password            = "${var.database_password}"
  sgs                 = ["${module.rds_sg.sg_id}"]
  db_parameter_group  = "${var.environment}-parameter-group"
   db_parameter_group_family = "mysql5.7"
  subnets             = ["${element(split(",",module.vpc.private_ids), 0)}","${element(split(",",module.vpc.private_ids_1B), 0)}"]
}
