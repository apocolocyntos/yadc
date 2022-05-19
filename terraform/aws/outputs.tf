output "vailabitlity" {
  value = data.aws_availability_zones.available.zone_ids
}

output "eks" {
  value = aws_eks_cluster.eks_cluster_default
}

output "subnetcidr" {
  value = cidrsubnet(aws_vpc.default.cidr_block, 8, 0)
}
