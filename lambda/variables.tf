variable "project_name" {
  type        = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
