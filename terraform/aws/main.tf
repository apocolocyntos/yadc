
resource "aws_vpc" "vpc_eks" {
  cidr_block = "172.29.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "security_group_eks" {
  vpc_id      = aws_vpc.vpc_eks.id
  name        = "eks"
  description = "EKS VPC security group"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
  ]
  revoke_rules_on_delete = true
  tags                   = var.tags
}
