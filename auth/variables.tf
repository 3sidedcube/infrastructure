variable "project_name" {
  type = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "access_token_validity_minutes" {
  type = number
  description = "Minutes access token will be valid for"
  default = 15
}

variable "refresh_token_validity_days" {
  type = number
  description = "Days refresh token will be valid for"
  default = 30
}

variable "callback_urls" {
  type = set(string)
  description = "List of callback URLs to redirect to"
  default = []
}