variable "aws_profile" {
  type        = string
  description = "Profile to access AWS"
}

variable "root" {
  type        = string
  description = "Hosted zone domain root e.g. staging.cpni.3sidedcu.be"
}

variable "wildcard" {
  type        = bool
  default     = true
  description = "Issue wildcard certificate for root domain"
}
