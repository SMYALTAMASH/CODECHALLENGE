output "id" {
     value = "${aws_vpc.main.id}"
}

output "igw" {
     value = "${aws_internet_gateway.igw.id}"
}

output "nat-gw" {
     value = "${aws_nat_gateway.nat-gw.id}"
}


output "public_ids" {
 value = "${join(",",aws_subnet.public_subnet.*.id) }"
}

output "private_ids" {
 value = "${join(",",aws_subnet.private_subnet.*.id) }"
}


output "public_ids_1B" {
 value = "${join(",",aws_subnet.public_subnet_1B.*.id) }"
}

output "private_ids_1B" {
 value = "${join(",",aws_subnet.private_subnet_1B.*.id) }"
}
