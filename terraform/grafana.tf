resource "aws_subnet" "grafana" {
    vpc_id                  = "${aws_vpc.yadc.id}"
    cidr_block              = "${cidrsubnet(aws_vpc.yadc.cidr_block,8,2)}"
    map_public_ip_on_launch = true
}



resource "aws_route_table_association" "grafana" {
    subnet_id      = "${aws_subnet.grafana.id}"
    route_table_id = "${aws_route_table.yadc.id}"
}

resource "aws_security_group" "grafana" {
    name        = "grafana"
    description = "Allow Grafana"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol = "tcp"
        from_port = "${var.prometheus.server.port}"
        to_port   = "${var.prometheus.server.port}"
        cidr_blocks = [
            "${aws_subnet.prometheus.cidr_block}",
            "${aws_subnet.grafana.cidr_block}"
        ]
    }
    egress {
        protocol = "tcp"
        from_port = "${var.prometheus.server.port}"
        to_port   = "${var.prometheus.server.port}"
        cidr_blocks = [
            "${aws_subnet.prometheus.cidr_block}",
            "${aws_subnet.grafana.cidr_block}"
        ]
    }
}


# TODO: Restrict access from and to server
resource "aws_instance" "grafana" {
    ami                    = "${var.aws_instance.ami}"
    count                  = 1
    instance_type          = "${var.aws_instance.instance_type}"
    key_name               = "${aws_key_pair.yadc.key_name}"
    vpc_security_group_ids = [
                                "${aws_security_group.ssh_in.id}",
                                "${aws_security_group.http_out.id}",
                                "${aws_security_group.https_out.id}",
                                "${aws_security_group.grafana.id}"
                            ]
    subnet_id              = "${aws_subnet.grafana.id}"
    tags = {
        Name               = "grafana-${count.index}"
        os                 = "${var.aws_instance.tags.os}"
        group              = "grafana"
    }
}
