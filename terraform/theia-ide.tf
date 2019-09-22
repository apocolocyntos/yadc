resource "aws_subnet" "theia-ide" {
    vpc_id                  = "${aws_vpc.yadc.id}"
    cidr_block              = "${cidrsubnet(aws_vpc.yadc.cidr_block,8,3)}"
    map_public_ip_on_launch = true
}



resource "aws_route_table_association" "theia-ide" {
    subnet_id      = "${aws_subnet.theia-ide.id}"
    route_table_id = "${aws_route_table.yadc.id}"
}

# Allow incoming from the internet
resource "aws_security_group" "theia-ide_public" {
    name        = "theia-ide_public"
    description = "Allow theia-ide Public"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol  = "tcp"
        from_port = 8080
        to_port   = 8080
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "theia-ide Public"
    }
}

resource "aws_security_group" "theia-ide" {
    name        = "theia-ide"
    description = "Allow theia-ide"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol = "tcp"
        from_port = "${var.prometheus.server.port}"
        to_port   = "${var.prometheus.server.port}"
        cidr_blocks = [
            "${aws_subnet.prometheus.cidr_block}",
            "${aws_subnet.theia-ide.cidr_block}"
        ]
    }
    egress {
        protocol = "tcp"
        from_port = "${var.prometheus.server.port}"
        to_port   = "${var.prometheus.server.port}"
        cidr_blocks = [
            "${aws_subnet.prometheus.cidr_block}",
            "${aws_subnet.theia-ide.cidr_block}"
        ]
    }
}


# TODO: Restrict access from and to server
resource "aws_instance" "theia-ide" {
    ami                    = "${var.aws_instance.ami}"
    count                  = "${var.aws_instance.count}"
    instance_type          = "${var.aws_instance.instance_type}"
    key_name               = "${aws_key_pair.yadc.key_name}"
    vpc_security_group_ids = [
                                "${aws_security_group.ssh_in.id}",
                                "${aws_security_group.default_out.id}",
                                "${aws_security_group.prometheus.id}",
                                "${aws_security_group.theia-ide.id}",
                                "${aws_security_group.theia-ide_public.id}"
                            ]
    subnet_id              = "${aws_subnet.theia-ide.id}"
    tags = {
        Name               = "theia-ide-${count.index}"
        os                 = "${var.aws_instance.tags.os}"
        group              = "theia-ide"
    }
}
