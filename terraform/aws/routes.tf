# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "route_table_default" {
  vpc_id = aws_vpc.vpc_default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_default.id
  }
  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "internet_gateway_default" {
  vpc_id = aws_vpc.vpc_default.id
  tags   = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "rtbaccoc_a" {
  subnet_id      = aws_subnet.subnet_default_a.id
  route_table_id = aws_route_table.route_table_default.id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "rtbaccoc_b" {
  subnet_id      = aws_subnet.subnet_default_b.id
  route_table_id = aws_route_table.route_table_default.id
}

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
# resource "aws_route_table_association" "rtbaccoc_c" {
#   subnet_id      = aws_subnet.subnet_default_c.id
#   route_table_id = aws_route_table.route_table_default.id
# }
