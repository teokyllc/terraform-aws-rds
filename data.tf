data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnets" "rds_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    rds_subnet = "true"
  }
}

data "aws_region" "current" {}
