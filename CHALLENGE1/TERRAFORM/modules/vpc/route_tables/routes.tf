resource "aws_route_table" "public-routes" {
   vpc_id = "${var.main}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${var.igw}"
   }
}

resource "aws_route_table" "private-routes" {
   vpc_id = "${var.main}"
   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${var.nat-gw}"
   }
}

resource "aws_route_table_association" "public-route-assoc" {
    count          = "${var.pub_count}"    
    subnet_id      = "${element(split(",",var.pub_subnet_ids), count.index)}"
    route_table_id = "${aws_route_table.public-routes.id}"
}

resource "aws_route_table_association" "private-route-assoc" {
    count = "${var.pri_count}"
    subnet_id      = "${element(split(",",var.pri_subnet_ids), count.index)}"
    route_table_id = "${aws_route_table.private-routes.id}"
}


