locals {
  name = "${var.project_name}-network"
  cidr = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.cidr
  azs  = data.aws_availability_zones.available.names

  public_subnets  = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.cidr, 8, k)]
  private_subnets = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.cidr, 8, k + 10)]

  enable_nat_gateway = true
}

resource "aws_security_group" "lambda" {
  name = "${local.name}-lambda-sg"
  vpc_id = module.vpc.vpc_id
}