output "glue_scripts" {
  description = "AWS Glue scripts storage bucket"
  value       = aws_s3_bucket.glue_scripts
}

output "glue_temp" {
  description = "AWS Glue temp storage bucket"
  value       = aws_s3_bucket.glue_temp
}

output "raw_data" {
  description = "Raw data storage bucket"
  value       = aws_s3_bucket.raw
}

output "refined_data" {
  description = "Refined data storage bucket"
  value       = aws_s3_bucket.refined
}

output "trusted_data" {
  description = "Trusted data storage bucket"
  value       = aws_s3_bucket.trusted
}

output "glue_role_arn" {
  description = "ARN of IAM role for AWS Glue crawler and jobs"
  value       = aws_iam_role.application.arn
}

output "lake_formation_confidentiality_tag" {
  description = "LF Confidentiality Tag"
  value       = aws_lakeformation_lf_tag.confidentiality
}
