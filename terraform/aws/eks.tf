resource "aws_iam_role" "iam_role_eks_default" {
  name = "eks-cluster-default"

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

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_eks_default_EKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_eks_default.name
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_eks_default_EKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.iam_role_eks_default.name
}

resource "aws_eks_cluster" "eks_cluster_default" {
  name     = "default"
  role_arn = aws_iam_role.iam_role_eks_default.arn

  version = "1.23"

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_default_a.id,
      aws_subnet.subnet_default_b.id,
      aws_subnet.subnet_default_c.id,
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.iam_role_policy_attachment_eks_default_EKSClusterPolicy,
    aws_iam_role_policy_attachment.iam_role_policy_attachment_eks_default_EKSVPCResourceController,
  ]
}
