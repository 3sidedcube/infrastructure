output "aws_acm_certificate_name" {
  description = "Name of created certificate"
  value       = aws_acm_certificate.main.domain_name
}

output "aws_acm_certificate_arn" {
  description = "ARN of created certificate"
  value       = aws_acm_certificate.main.arn
}
