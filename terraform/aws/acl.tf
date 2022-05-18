
#
# ACL
#

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
resource "aws_network_acl" "network_acl_default" {
  vpc_id     = aws_vpc.vpc_default.id
  subnet_ids = [aws_subnet.subnet_default_a.id, aws_subnet.subnet_default_b.id, aws_subnet.subnet_default_c.id]
  tags       = var.tags
}
