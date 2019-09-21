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
