variable "project_name" {
  type = string
  description = "Project name and environment name, used to prefix resources. Example: cpni-phish-staging"
}

variable "username" {
  type = string
  description = "DB Username"
  default = "admin"
}

variable "db_name" {
  type = string
  description = "DB Name"
  default = "dev"
}

variable "private_subnet_ids" {
  type        = list(any)
  description = "IDs of private subnets to create database in"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to create database in"
}

variable "backup_retention_period" {
  type = number
  description = "Days to retain backup for"
  default = 7
}

variable "auto_pause" {
  type = bool
  description = "Automatically pause DB when there is no traffic"
  default = false
}

variable "scaling_max_capacity" {
  type = number
  description = "Maximum capacity to scale to (2, 4, 8, 16, 32, 64, 192, 384)"
  default = 32
}

variable "deletion_protection" {
  type = bool
  default = true
  description = "Prevent the database from being deleted"
}