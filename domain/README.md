## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.acm_provider"></a> [aws.acm\_provider](#provider\_aws.acm\_provider) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | URL of API e.g. api.staging.cpni.3sidedcu.be | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Profile to access AWS | `string` | n/a | yes |
| <a name="input_root"></a> [root](#input\_root) | Hosted zone domain root e.g. staging.cpni.3sidedcu.be | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_acm_certificate_arn"></a> [aws\_acm\_certificate\_arn](#output\_aws\_acm\_certificate\_arn) | ARN of created certificate |
| <a name="output_aws_acm_certificate_name"></a> [aws\_acm\_certificate\_name](#output\_aws\_acm\_certificate\_name) | Name of created certificate |
| <a name="output_nameservers"></a> [nameservers](#output\_nameservers) | Nameservers |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | ID of created Zone |
