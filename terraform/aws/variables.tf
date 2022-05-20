variable "region" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    "default" = "true"
  }
}

variable "eks_cluster_name" {
  type    = string
  default = "cluster-0"
}
