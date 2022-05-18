variable "region" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    "default" = "true"
  }
}
