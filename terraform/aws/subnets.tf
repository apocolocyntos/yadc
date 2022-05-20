resource "aws_subnet" "subnet_eks" {
  count                   = length(data.aws_availability_zones.available.zone_ids)
  vpc_id                  = aws_vpc.vpc_eks.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[count.index]
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(aws_vpc.vpc_eks.cidr_block, 4, count.index)
  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}" = "shared"
  }
}



#
# ACL
#

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
resource "aws_network_acl" "network_acl_default" {
  vpc_id     = aws_vpc.vpc_eks.id
  subnet_ids = aws_subnet.subnet_eks[*].id
  tags       = var.tags
}



#
# Routes
#

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "rtbaccoc_a" {
  count          = length(aws_subnet.subnet_eks)
  subnet_id      = aws_subnet.subnet_eks[count.index].id
  route_table_id = aws_route_table.route_table_eks.id
}
