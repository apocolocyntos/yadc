variable "aws_vpc" {
    default = {
        cidr_block = "172.16.0.0/16"
    }
}

variable "aws_instance" {
    default = {
        ami = "ami-0ac05733838eabc06"
        instance_type = "t2.micro"
        count = 3
        tags = {
            os = "ubuntu"
        }
    }
}




variable "prometheus" {
    default = {
        server = {
            port = 9090
        }
        node = {
            port = 9100
        }
    }
}

variable "grafana" {
    default = {
        port = 3000
    }
}
