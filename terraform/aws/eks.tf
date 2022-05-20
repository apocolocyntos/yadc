#
# Control-Plane
#

resource "aws_iam_role" "iam_role_eks" {
  name = "eks-cluster"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_eks_EKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_eks.name
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_eks_EKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.iam_role_eks.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "cluster-0"
  role_arn = aws_iam_role.iam_role_eks.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet_eks[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.iam_role_policy_attachment_eks_EKSClusterPolicy,
    aws_iam_role_policy_attachment.iam_role_policy_attachment_eks_EKSVPCResourceController,
  ]
}



#
# Node-Groups
#

resource "aws_iam_role" "iam_role_eks_node_group" {
  name = "eks-cluster-node-group-0"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_node_group_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam_role_eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_node_group_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam_role_eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_node_group_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam_role_eks_node_group.name
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node-group-0"
  node_role_arn   = aws_iam_role.iam_role_eks_node_group.arn
  subnet_ids      = aws_subnet.subnet_eks[*].id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.iam_role_policy_attachment_node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.iam_role_policy_attachment_node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.iam_role_policy_attachment_node_group_AmazonEC2ContainerRegistryReadOnly,
  ]
}
