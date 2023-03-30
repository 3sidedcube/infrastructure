provider "aws" {
  alias   = "acm_provider"
  profile = var.aws_profile
  region  = "us-east-1"
}

resource "aws_route53_zone" "main" {
  name = var.root
}