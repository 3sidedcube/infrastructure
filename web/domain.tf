resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.app_url
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.main.domain_name]
}

resource "aws_acm_certificate" "main" {
  provider          = aws.acm_provider
  domain_name       = var.app_url
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count = length(aws_acm_certificate.main.domain_validation_options)

  allow_overwrite = true
  name            = element(aws_acm_certificate.main.domain_validation_options.*.resource_record_name, count.index)
  type            = element(aws_acm_certificate.main.domain_validation_options.*.resource_record_type, count.index)
  records         = [element(aws_acm_certificate.main.domain_validation_options.*.resource_record_value, count.index)]
  zone_id         = var.zone_id
  ttl             = 60
  provider        = aws.acm_provider
}

resource "aws_acm_certificate_validation" "main" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
