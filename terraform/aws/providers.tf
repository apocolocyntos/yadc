provider "aws" {
  region = var.region
}

# data "aws_eks_cluster_auth" "eks_cluster_auth" {
#   name = aws_iam_role.iam_role_eks.name
# }

# provider "kubernetes" {
#   host                   = aws_eks_cluster.eks_cluster_auth.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
#   load_config_file       = false
# }
