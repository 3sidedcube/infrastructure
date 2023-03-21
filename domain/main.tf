provider "aws" {
  alias   = "acm_provider"
  profile = var.aws_profile
  region  = "us-east-1"
}

resource "aws_route53_zone" "main" {
  name = var.root
}

resource "aws_acm_certificate" "main" {
  provider          = aws.acm_provider
  domain_name       = var.root
  validation_method = "DNS"

  subject_alternative_names = var.wildcard ? ["*.${var.root}"] : []

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
  zone_id         = aws_route53_zone.main.id
  ttl             = 60
  provider        = aws.acm_provider
}

resource "aws_acm_certificate_validation" "main" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
