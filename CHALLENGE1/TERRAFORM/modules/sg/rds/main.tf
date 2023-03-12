resource "aws_security_group" "rds_sg" {
  name = "RDS_SG"
  vpc_id = "${var.vpc_id}"
  description = "RDS SG"

 tags {
        Name = "RDS_SG"
    }
}

resource "aws_security_group_rule" "rds_sg_id" {
    type = "ingress"
    from_port = "${var.port_mysql}"
    to_port = "${var.port_mysql}"
    protocol = "tcp"
    security_group_id = "${aws_security_group.rds_sg.id}"
    source_security_group_id = "${var.sg_id}"
}

output "sg_id" {
  value = "${aws_security_group.rds_sg.id}"
}