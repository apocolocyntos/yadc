resource "aws_subnet" "prometheus" {
    vpc_id                  = "${aws_vpc.yadc.id}"
    cidr_block              = "${cidrsubnet(aws_vpc.yadc.cidr_block,8,1)}"
    map_public_ip_on_launch = true
}



resource "aws_route_table_association" "prometheus" {
    subnet_id      = "${aws_subnet.prometheus.id}"
    route_table_id = "${aws_route_table.yadc.id}"
}


resource "aws_security_group" "prometheus" {
    name        = "prometheus"
    description = "Allow Prometheus"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol = "tcp"
        from_port = "${var.prometheus.node.port}"
        to_port   = "${var.prometheus.node.port}"
        cidr_blocks = [
            "${aws_vpc.yadc.cidr_block}"
        ]
    }
    egress {
        protocol = "tcp"
        from_port = "${var.prometheus.node.port}"
        to_port   = "${var.prometheus.node.port}"
        cidr_blocks = [
            "${aws_vpc.yadc.cidr_block}"
        ]
    }
    tags = {
        Name = "Prometheus"
    }
}



resource "aws_instance" "prometheus" {
    ami                    = "${var.aws_instance.ami}"
    count                  = "${var.aws_instance.count}"
    instance_type          = "${var.aws_instance.instance_type}"
    key_name               = "${aws_key_pair.yadc.key_name}"
    vpc_security_group_ids = [
                                "${aws_security_group.ssh_in.id}",
                                "${aws_security_group.default_out.id}",
                                "${aws_security_group.prometheus.id}",
                                "${aws_security_group.grafana.id}"
                            ]
    subnet_id              = "${aws_subnet.prometheus.id}"
    tags = {
        Name               = "prometheus-${count.index}"
        os                 = "${var.aws_instance.tags.os}"
        group              = "prometheus"
    }
}
