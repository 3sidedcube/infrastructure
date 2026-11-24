variable "project_name" {
  type = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Use one NAT gateway for all private subnets instead of one per availability zone. Cheaper, but outbound traffic from every AZ stops if that AZ fails."
}
