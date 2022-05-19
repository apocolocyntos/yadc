resource "aws_subnet" "subnet_default_a" {
  vpc_id                  = aws_vpc.vpc_default.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[0]
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(aws_vpc.vpc_default.cidr_block, 4, 0)
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_b" {
  vpc_id                  = aws_vpc.vpc_default.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[1]
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(aws_vpc.vpc_default.cidr_block, 4, 1)
  tags                    = var.tags
}

resource "aws_subnet" "subnet_default_c" {
  vpc_id                  = aws_vpc.vpc_default.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[2]
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(aws_vpc.vpc_default.cidr_block, 4, 2)
  tags                    = var.tags
}
