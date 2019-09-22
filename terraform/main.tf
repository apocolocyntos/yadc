provider "aws" {
    region = "${var.aws.region}"
}


# SSH-Key, defined in env.tf which is excluded by gitignore
resource "aws_key_pair" "yadc" {
    key_name = "yadc"
    public_key = "${var.ssh_key}"
}



resource "aws_vpc" "yadc" {
    cidr_block = "${var.aws_vpc.cidr_block}"
}



resource "aws_internet_gateway" "yadc" {
    vpc_id = "${aws_vpc.yadc.id}"
}



# Routing
resource "aws_route_table" "yadc" {
    vpc_id = "${aws_vpc.yadc.id}"
}



resource "aws_route" "yadc" {
    route_table_id = "${aws_route_table.yadc.id}"
    gateway_id     = "${aws_internet_gateway.yadc.id}"
    destination_cidr_block = "0.0.0.0/0"
}



# Allow ingoing ssh traffic
resource "aws_security_group" "ssh_in" {
    name        = "ssh_in"
    description = "Allow SSH In"
    vpc_id      = "${aws_vpc.yadc.id}"
    ingress {
        protocol  = "tcp"
        from_port = 22
        to_port   = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "SSH In"
    }
}



# Allow outgoing http traffic
resource "aws_security_group" "default_out" {
    name        = "default_out"
    description = "Allow Default Out"
    vpc_id      = "${aws_vpc.yadc.id}"
    egress {
        protocol  = "tcp"
        from_port = 80
        to_port   = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol  = "tcp"
        from_port = 443
        to_port   = 443
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "HTTP Out"
    }
}
