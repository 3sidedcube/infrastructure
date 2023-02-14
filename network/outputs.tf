output "id" {
  value = module.vpc.vpc_id
}

output "cidr" {
  value = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "lambda_security_group_id" {
  value = aws_security_group.lambda.id
}