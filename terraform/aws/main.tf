
resource "aws_vpc" "vpc_default" {
  cidr_block = "172.31.0.0/16"
}


resource "aws_subnet" "subnet_default_a" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.16.0/20"
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_b" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.32.0/20"
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_c" {
  vpc_id                  = aws_vpc.vpc_default.id
  map_public_ip_on_launch = true
  cidr_block              = "172.31.0.0/20"
  tags                    = var.tags
}
