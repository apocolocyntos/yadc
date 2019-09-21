resource "aws_subnet" "prometheus" {
    vpc_id                  = "${aws_vpc.yadc.id}"
    cidr_block              = "${cidrsubnet(aws_vpc.yadc.cidr_block,8,1)}"
    map_public_ip_on_launch = true
}



resource "aws_route_table_association" "prometheus" {
    subnet_id      = "${aws_subnet.prometheus.id}"
    route_table_id = "${aws_route_table.yadc.id}"
}


resource "aws_security_group" "prometheus_in" {
    name        = "prometheus_in"
    description = "Allow Prometheus In"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol = "tcp"
        from_port = 9100
        to_port   = 9100
        cidr_blocks = ["${aws_subnet.prometheus.cidr_block}"]
    }
    egress {
        protocol = "tcp"
        from_port = 9100
        to_port   = 9100
        cidr_blocks = ["${aws_subnet.prometheus.cidr_block}"]
    }
    tags = {
        Name = "Prometheus In"
    }
}

resource "aws_instance" "prometheus" {
    ami                    = "${var.aws_instance.ami}"
    count                  = "${var.aws_instance.count}"
    instance_type          = "${var.aws_instance.instance_type}"
    key_name               = "${aws_key_pair.yadc.key_name}"
    vpc_security_group_ids = [
                                "${aws_security_group.ssh_in.id}",
                                "${aws_security_group.http_out.id}",
                                "${aws_security_group.https_out.id}",
                                "${aws_security_group.prometheus_in.id}"
                            ]
    subnet_id              = "${aws_subnet.prometheus.id}"
    tags = {
        Name               = "prometheus-${count.index}"
        os                 = "${var.aws_instance.tags.os}"
        group              = "prometheus"
    }
}
