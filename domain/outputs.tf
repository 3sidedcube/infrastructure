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