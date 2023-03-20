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
