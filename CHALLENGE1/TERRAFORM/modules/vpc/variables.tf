variable "env" { }
variable "vpc_cidr"       {}

variable "availability_zone" {
  default = {
    "0" = "us-west-1a"
    "1" = "us-west-1c"
  }
}

variable "subnet_public_count" { }
variable "subnet_public_count_1B" { }

variable "public_cidr" {}
variable "public_cidr_1B" {}

variable "public_subnet_name" {}
variable "public_subnet_name_1B" {}

variable "subnet_private_count" { }
variable "subnet_private_count_1B" { }

variable "private_cidr" { }
variable "private_cidr_1B" { }

variable "private_subnet_name" { }
variable "private_subnet_name_1B" { }
