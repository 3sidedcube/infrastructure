locals {
  name = "${var.project_name}-db"
}

data "aws_subnet" "subnets" {
  for_each = toset(var.private_subnet_ids)
  id       = each.value
}

resource "random_password" "main" {
  length            = 40
  special           = true
  min_special       = 5
  override_special  = "!#$%^&*()-_=+[]{}<>:?"
  keepers           = {
    pass_version  = 1
  }
}

resource "aws_db_subnet_group" "main" {
  name       = local.name
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "main" {
  name = "${local.name}"

  description = "Security group for ${local.name} database"
  vpc_id      = var.vpc_id


  # Only Postgres in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnets).*.cidr_block
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = values(data.aws_subnet.subnets).*.cidr_block
  }
}

resource "aws_rds_cluster" "main" {
  cluster_identifier        = local.name
  engine                    = "aurora-postgresql"
  engine_mode               = "serverless"
  enable_http_endpoint      = true
  database_name             = lower(var.db_name)
  master_username           = lower(var.username)
  master_password           = random_password.main.result
  backup_retention_period   = var.backup_retention_period
  vpc_security_group_ids    = ["${aws_security_group.main.id}"]
  db_subnet_group_name      = aws_db_subnet_group.main.id
  final_snapshot_identifier = "${local.name}-final-snapshot"

  scaling_configuration {
    auto_pause   = var.auto_pause
    min_capacity = 2
    max_capacity = var.scaling_max_capacity
  }
}
