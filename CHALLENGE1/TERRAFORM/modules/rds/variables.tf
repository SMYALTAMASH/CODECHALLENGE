variable "rds_name" {}
variable "engine" {}
variable "engine_version" {}
variable "allocated_storage" {}
variable "rds_storage_type" {}
variable "instance_class" {}
variable "username" {}
variable "password" {}
variable "sgs" { type="list" }
variable "db_parameter_group" {}
variable "subnets" { type="list" }
variable "iops" { default="0" }
variable "db_parameter_group_family" {}
variable "multi_az" {}