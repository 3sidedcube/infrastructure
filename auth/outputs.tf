output "user_pool_arn" {
  value       = aws_cognito_user_pool.main.arn
  description = "Cognito User Pool ARN"
}

output "hosted_domain" {
  value = aws_cognito_user_pool_domain.domain.domain
}

output "client_id" {
  value = aws_cognito_user_pool_client.main.id
}