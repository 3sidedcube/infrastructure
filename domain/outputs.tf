output "zone_id" {
  description = "ID of created Zone"
  value       = aws_route53_zone.main.zone_id
}

output "zone_name" {
  description = "Root name of created Zone"
  value       = aws_route53_zone.main.name
}

output "nameservers" {
  description = "Nameservers"
  value       = aws_route53_zone.main.name_servers
}

output "aws_acm_certificate_name" {
  description = "Name of created certificate"
  value       = aws_acm_certificate.main.domain_name
}

output "aws_acm_certificate_arn" {
  description = "ARN of created certificate"
  value       = aws_acm_certificate.main.arn
}
