variable "aws_profile" {
  type        = string
  description = "Profile to access AWS"
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID"
}

variable "wildcard" {
  type        = bool
  default     = true
  description = "Issue wildcard certificate for root domain"
}
