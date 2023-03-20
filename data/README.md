# Data Module

This Terraform module creates a standard AWS Data Lake, made up of:

1.  3 data stages (Raw, Refined, Trusted) in S3
2.  AWS Lake Formation for permissions management
3.  AWS Glue for scripts

This module creates #1 & #2, and leaves managing the Glue scripts and workflows up to the calling module.

**Upload a script to the created S3 bucket:**

```terraform
# AWS Glue Job Helpers
resource "aws_s3_object" "helpers" {
  bucket      = module.data.glue_scripts.bucket
  key         = "python-modules/data_platform_glue_job_helpers-1.0-py3-none-any.whl"
  acl         = "private"
  source      = "../../../scripts/data/dist/cpni_phish_data_glue_job_helpers-1.0-py3-none-any.whl"
  source_hash = filemd5("../../../scripts/data/dist/cpni_phish_data_glue_job_helpers-1.0-py3-none-any.whl")
}

# AWS Glue Job Scripts
module "scripts" {
  source = "hashicorp/dir/template"

  base_dir = "${path.module}/../../../scripts/data/jobs/"
}

resource "aws_s3_object" "scripts" {
  for_each = module.scripts.files

  bucket       = module.data.glue_scripts.bucket
  key          = each.key
  content_type = each.value.content_type

  # The template_files module guarantees that only one of these two attributes
  # will be set for each file, depending on whether it is an in-memory template
  # rendering result or a static file on disk.
  source  = each.value.source_path
  content = each.value.content

  # Unless the bucket has encryption enabled, the ETag of each object is an
  # MD5 hash of that object.
  etag = each.value.digests.md5
}
```

**Create an AWS Glue Script:**

```terraform
resource "aws_glue_job" "application_import" {
  name              = "${local.name_prefix}-application-import"
  role_arn          = module.data.glue_role_arn
  max_retries       = 0
  number_of_workers = 2
  glue_version      = "4.0"
  worker_type       = "G.1X"

  connections = tolist([aws_glue_connection.application.name])

  command {
    script_location = "s3://${module.data.glue_scripts.bucket}/raw/ingest_application_database_raw.py"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"          = "s3://${module.data.glue_temp.bucket}/raw/ingest_application_database/"
    "--extra-py-files"   = "s3://${aws_s3_object.helpers.bucket}/${aws_s3_object.helpers.key}"
    "--s3_bucket_target" = module.data.raw_data.id
    "--s3_prefix"        = "application/"
    "--source_data_database"       = aws_glue_catalog_database.application_import.name
    "--glue_database_name_source"  = aws_glue_catalog_database.application_import.name
    "--s3_ingestion_bucket_target" = "s3://${module.data.raw_data.bucket}/application"
    "--enable-glue-datacatalog"          = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--write-shuffle-files-to-s3"        = "true"
    "--write-shuffle-spills-to-s3"       = "true"
  }
}

```

<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                        | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_role.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                            | resource    |
| [aws_iam_role_policy.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                              | resource    |
| [aws_iam_role_policy_attachment.application_glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)   | resource    |
| [aws_lakeformation_data_lake_settings.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_data_lake_settings)   | resource    |
| [aws_lakeformation_lf_tag.confidentiality](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_lf_tag)                | resource    |
| [aws_lakeformation_permissions.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_permissions)          | resource    |
| [aws_lakeformation_permissions.raw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_permissions)                  | resource    |
| [aws_lakeformation_permissions.refined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_permissions)              | resource    |
| [aws_lakeformation_permissions.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_permissions)              | resource    |
| [aws_lakeformation_resource.raw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_resource)                        | resource    |
| [aws_lakeformation_resource.refined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_resource)                    | resource    |
| [aws_lakeformation_resource.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_resource)                    | resource    |
| [aws_s3_bucket.glue_scripts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                         | resource    |
| [aws_s3_bucket.glue_temp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                            | resource    |
| [aws_s3_bucket.raw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                  | resource    |
| [aws_s3_bucket.refined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                              | resource    |
| [aws_s3_bucket.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                              | resource    |
| [aws_s3_bucket_public_access_block.glue_scripts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource    |
| [aws_s3_bucket_public_access_block.glue_temp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)    | resource    |
| [aws_s3_bucket_public_access_block.raw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)          | resource    |
| [aws_s3_bucket_public_access_block.refined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)      | resource    |
| [aws_s3_bucket_public_access_block.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)      | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                               | data source |
| [aws_iam_policy_document.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                   | data source |
| [aws_iam_policy_document.glue_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)              | data source |
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context)                       | data source |

## Inputs

| Name                                                                  | Description                                                                              | Type     | Default | Required |
| --------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_project_name"></a> [project_name](#input_project_name) | Project name and environment name, used to prefix resources. Example: cpni-phish-staging | `string` | n/a     |   yes    |

## Outputs

| Name                                                                                                     | Description                                   |
| -------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| <a name="output_glue_role_arn"></a> [glue_role_arn](#output_glue_role_arn)                               | ARN of IAM role for AWS Glue crawler and jobs |
| <a name="output_glue_scripts_bucket_arn"></a> [glue_scripts_bucket_arn](#output_glue_scripts_bucket_arn) | ARN of AWS Glue scripts storage bucket        |
| <a name="output_glue_temp_bucket_arn"></a> [glue_temp_bucket_arn](#output_glue_temp_bucket_arn)          | ARN of AWS Glue temp storage bucket           |
| <a name="output_raw_data_bucket_arn"></a> [raw_data_bucket_arn](#output_raw_data_bucket_arn)             | ARN of Raw data storage bucket                |
| <a name="output_refined_data_bucket_arn"></a> [refined_data_bucket_arn](#output_refined_data_bucket_arn) | ARN of Refined data storage bucket            |
| <a name="output_trusted_data_bucket_arn"></a> [trusted_data_bucket_arn](#output_trusted_data_bucket_arn) | ARN of Trusted data storage bucket            |

<!-- END_TF_DOCS -->
