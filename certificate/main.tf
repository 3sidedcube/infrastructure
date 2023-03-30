provider "aws" {
  alias   = "acm_provider"
  profile = var.aws_profile
  region  = "us-east-1"
}

data "aws_route53_zone" "main" {
  zone_id = var.zone_id
}

resource "aws_acm_certificate" "main" {
  provider          = aws.acm_provider
  domain_name       = data.aws_route53_zone.main.name
  validation_method = "DNS"

  subject_alternative_names = var.wildcard ? ["*.${data.aws_route53_zone.main.name}"] : []

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.id
  provider        = aws.acm_provider
}

resource "aws_acm_certificate_validation" "main" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
