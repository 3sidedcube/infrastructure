## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_rds_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_subnet.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_pause"></a> [auto\_pause](#input\_auto\_pause) | Automatically pause DB when there is no traffic | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Days to retain backup for | `number` | `7` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | DB Name | `string` | `"dev"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of private subnets to create database in | `list(any)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name and environment name, used to prefix resources. Example: cpni-phish-staging | `string` | n/a | yes |
| <a name="input_scaling_max_capacity"></a> [scaling\_max\_capacity](#input\_scaling\_max\_capacity) | Maximum capacity to scale to (2, 4, 8, 16, 32, 64, 192, 384) | `number` | `32` | no |
| <a name="input_username"></a> [username](#input\_username) | DB Username | `string` | `"admin"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC to create database in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | Database password |
