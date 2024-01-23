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

data "aws_ssm_parameter" "admin_user" {
  name = var.admin_user_parameter_name
}

data "aws_ssm_parameter" "admin_password" {
  name = var.admin_password_parameter_name
}