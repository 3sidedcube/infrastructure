variable "project_name" {
  type        = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "aws_profile" {
  type        = string
  description = "Profile to access AWS"
}

variable "zone_id" {
  type        = string
  description = "Route53 DNS Zone ID"
}

variable "app_url" {
  type        = string
  description = "App URL"
}

variable "repo_name" {
  type = string
  description = "GitHub Repo Name"
}

variable "minimum_protocol_version" {
  type        = string
  default     = "TLSv1"
  description = "Oldest TLS version and ciphers the CloudFront distribution accepts from browsers, for example TLSv1.2_2021. The default keeps CloudFront's own default, so existing distributions don't change."
}
