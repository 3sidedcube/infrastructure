## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_validity_minutes"></a> [access\_token\_validity\_minutes](#input\_access\_token\_validity\_minutes) | Minutes access token will be valid for | `number` | `15` | no |
| <a name="input_callback_urls"></a> [callback\_urls](#input\_callback\_urls) | List of callback URLs to redirect to | `set(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name and environment name, used to prefix resources. Example: cpni-phish-staging | `string` | n/a | yes |
| <a name="input_refresh_token_validity_days"></a> [refresh\_token\_validity\_days](#input\_refresh\_token\_validity\_days) | Days refresh token will be valid for | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_hosted_domain"></a> [hosted\_domain](#output\_hosted\_domain) | n/a |
| <a name="output_user_pool_arn"></a> [user\_pool\_arn](#output\_user\_pool\_arn) | Cognito User Pool ARN |
