variable "project_name" {
  type        = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Use one NAT gateway, in the first availability zone, for all private subnets instead of one per AZ. Cheaper, but outbound traffic from every AZ stops if that AZ fails. Turning this on for an existing VPC deletes the other NAT gateways and their public IPs; turning it off again creates new ones with new IPs."
}
