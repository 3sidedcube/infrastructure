data "aws_iam_policy_document" "glue_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "application" {
  statement {
    actions = ["s3:ListObjects", "s3:ListBucket", "s3:HeadObject", "s3:GetObject", "s3:PutObject"]
    resources = [
      aws_s3_bucket.glue_scripts.arn,
      "${aws_s3_bucket.glue_scripts.arn}/*",
      aws_s3_bucket.raw.arn,
      "${aws_s3_bucket.raw.arn}/*",
      aws_s3_bucket.refined.arn,
      "${aws_s3_bucket.refined.arn}/*",
      aws_s3_bucket.trusted.arn,
    "${aws_s3_bucket.trusted.arn}/*"]
  }
  statement {
    actions = ["s3:ListBucket", "s3:HeadObject", "s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = [
      aws_s3_bucket.glue_temp.arn,
      "${aws_s3_bucket.glue_temp.arn}/*",
    ]
  }
  statement {
    actions   = ["lakeformation:GetDataAccess"]
    resources = ["*"]
  }

  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "application" {
  name                  = "${local.name_prefix}-application-crawler"
  assume_role_policy    = data.aws_iam_policy_document.glue_assume_role.json
  force_detach_policies = true
}

resource "aws_iam_role_policy" "application" {
  name   = aws_iam_role.application.name
  role   = aws_iam_role.application.id
  policy = data.aws_iam_policy_document.application.json
}

resource "aws_iam_role_policy_attachment" "application_glue" {
  role       = aws_iam_role.application.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_lakeformation_permissions" "application" {
  principal   = aws_iam_role.application.arn
  permissions = ["ALL"]

  lf_tag_policy {
    resource_type = "DATABASE"

    expression {
      key    = aws_lakeformation_lf_tag.confidentiality.key
      values = ["public", "sensitive", "private"]
    }
  }
}
