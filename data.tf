data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnets" "rds_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = var.rds_subnet_tier
  }
}

data "aws_region" "current" {}
