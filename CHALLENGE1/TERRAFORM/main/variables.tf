### Common stuff

variable "region" {  default = "us-east-1"}

variable "environment" {  default = "dev"}

variable "availability_zone"  { default = "us-west-1" }

variable "all_cidr" { default = "0.0.0.0/0" }

variable "ownerid"                      { default = "" }

variable "subnet_public_count"          { default = "1" }
variable "subnet_private_count"         { default = "1" }

variable "subnet_public_count_1B"          { default = "1" }
variable "subnet_private_count_1B"         { default = "1" }

variable "public_subnet_name"           { default = "0:DMZ" }
variable "public_subnet_name_1B"        { default = "0:DMZ-1B" }

variable "private_subnet_name"          { default = "1:THREAT-PRIVATE, 2:PRESENT-PRIVATE, 3:APP-PRIVATE, 4:DATA-PRIVATE" }
variable "private_subnet_name_1B"       { default = "1:THREAT-PRIVATE-1B, 2:PRESENT-PRIVATE-1B, 3:APP-PRIVATE-1B, 4:DATA-PRIVATE-1B" }

variable "env"                { default = "dev" }

###Network Components
variable "vpc_cidr"         { default = "10.0.0.0/16"}

variable "public_cidr"      { default = "0:10.0.0.0/24" }
variable "public_cidr_1B"   { default = "0:10.0.1.0/24" }

variable "public_subnet_cidr" { default = "10.0.0.0/24" }

variable "private_cidr"     { default = "1:10.0.2.0/24, 2:10.0.4.0/24, 3:10.0.6.0/24, 4:10.0.8.0/24" }
variable "private_cidr_1B"  { default = "1:10.0.3.0/24, 2:10.0.5.0/24, 3:10.0.7.0/24, 4:10.0.9.0/24" }

variable "database_name" { default = "ops" }
variable "database_username" { default = "ops" }
variable "database_password" { default = "opsdevopsxyz" }
variable "port_mysql" { default = 3306 }

