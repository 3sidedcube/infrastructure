locals {
  name_prefix = lower(var.project_name)
}

data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

resource "aws_s3_bucket" "glue_scripts" {
  bucket = "${local.name_prefix}-glue-scripts"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "glue_scripts" {
  bucket = aws_s3_bucket.glue_scripts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "glue_temp" {
  bucket = "${local.name_prefix}-glue-temp"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "glue_temp" {
  bucket = aws_s3_bucket.glue_temp.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "raw" {
  bucket = "${local.name_prefix}-raw-data"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "raw" {
  bucket = aws_s3_bucket.raw.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "refined" {
  bucket = "${local.name_prefix}-refined-data"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "refined" {
  bucket = aws_s3_bucket.refined.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "trusted" {
  bucket = "${local.name_prefix}-trusted-data"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "trusted" {
  bucket = aws_s3_bucket.trusted.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_lakeformation_lf_tag" "confidentiality" {
  key    = "Confidentiality"
  values = ["private", "sensitive", "public"]
}

resource "aws_lakeformation_resource" "raw" {
  arn = aws_s3_bucket.raw.arn
}

resource "aws_lakeformation_resource" "refined" {
  arn = aws_s3_bucket.refined.arn
}

resource "aws_lakeformation_resource" "trusted" {
  arn = aws_s3_bucket.trusted.arn
}

resource "aws_lakeformation_permissions" "raw" {
  principal   = aws_iam_role.application.arn
  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_lakeformation_resource.raw.arn
  }
}

resource "aws_lakeformation_permissions" "refined" {
  principal   = aws_iam_role.application.arn
  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_lakeformation_resource.refined.arn
  }
}

resource "aws_lakeformation_permissions" "trusted" {
  principal   = aws_iam_role.application.arn
  permissions = ["DATA_LOCATION_ACCESS"]

  data_location {
    arn = aws_lakeformation_resource.trusted.arn
  }
}

resource "aws_lakeformation_data_lake_settings" "main" {
  admins = [data.aws_iam_session_context.current.issuer_arn]
}
