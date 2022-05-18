# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options
resource "aws_vpc_dhcp_options" "dhcp_default" {
  domain_name         = "eu-central-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS", ]
  ntp_servers         = ["169.254.169.123"]
  tags                = var.tags
}
