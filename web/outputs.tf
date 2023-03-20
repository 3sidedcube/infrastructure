output "web_deployment_bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "cdn" {
  value = aws_cloudfront_distribution.main
}
