# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
# resource "aws_internet_gateway" "internet_gateway_eks" {
#   vpc_id = aws_vpc.vpc_eks.id
#   tags = {
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
#   }
# }

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# resource "aws_route_table" "route_table_eks" {
#   vpc_id = aws_vpc.vpc_eks.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internet_gateway_eks.id
#   }
#   tags = {
#     "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
#   }
# }
