provider "aws" {}

resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "${var.env}"
    }
}

# Internet-gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.main.id}"
}


#EIP for Nat attaching
resource "aws_eip" "nat" {
    vpc = true
}

#Nat gateway setup
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.public_subnet.id}"
}


resource "aws_subnet" "public_subnet" {
    count = "${var.subnet_public_count}"

    availability_zone = "${lookup(var.availability_zone, 0)}"
    cidr_block = "${element(split(":",element(split(",",var.public_cidr),count.index)), 1)}"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${element(split(":",element(split(",", var.public_subnet_name),count.index)), 3)}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = "${var.subnet_private_count}"

    availability_zone = "${lookup(var.availability_zone, 0)}"
    cidr_block = "${element(split(":",element(split(",",var.private_cidr),count.index)), 1)}"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${element(split(":",element(split(",", var.private_subnet_name),count.index)), 3)}"
    }
}


resource "aws_subnet" "public_subnet_1B" {
    count = "${var.subnet_public_count_1B}"

    availability_zone = "${lookup(var.availability_zone, 1)}"
    cidr_block = "${element(split(":",element(split(",",var.public_cidr_1B),count.index)), 1)}"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${element(split(":",element(split(",", var.public_subnet_name_1B),count.index)), 3)}"
    }
}

resource "aws_subnet" "private_subnet_1B" {
    count = "${var.subnet_private_count_1B}"

    availability_zone = "${lookup(var.availability_zone, 1)}"
    cidr_block = "${element(split(":",element(split(",",var.private_cidr_1B),count.index)), 1)}"
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${element(split(":",element(split(",", var.private_subnet_name_1B),count.index)), 3)}"
    }
}
