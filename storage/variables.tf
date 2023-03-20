variable "project_name" {
  type = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "cdn_url" {
  type = string
  description = "Location of CDN. e.g. cdn.staging.phish.cpni.3sidedcu.be"
}

variable "aws_profile" {
  type = string
  description = "Profile to access AWS"
}

variable "dns_zone" {
  type = string
  description = "Zone ID of Route53 DNS hosted zone"
}