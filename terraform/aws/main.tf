
resource "aws_vpc" "vpc_default" {
  cidr_block = "172.31.0.0/16"
}


resource "aws_subnet" "subnet_default_a" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.0.0/20"
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_b" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.16.0/20"
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_c" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.32.0/20"
  tags                    = var.tags
}


resource "aws_security_group" "security_group_default" {
  vpc_id      = aws_vpc.vpc_default.id
  name        = "default"
  description = "default VPC security group"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
  ]
  revoke_rules_on_delete = true
  tags                   = var.tags
}
