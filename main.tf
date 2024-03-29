resource "aws_security_group" "security_group" {
  name        = "${var.tags.environment}-${var.rds_instace_name}"
  description = "Security group for RDS instance ${var.tags.environment}-${var.db_name}."
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, {
    Name      = "${var.tags.environment}-${var.rds_instace_name}"
  })
}

resource "aws_security_group_rule" "publicly_accessible_rule" {
  count             = var.publicly_accessible ? 1 : 0
  type              = "ingress"
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "non_publicly_accessible_rule" {
  count             = var.publicly_accessible ? 0 : 1
  type              = "ingress"
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.vpc.cidr_block]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_db_parameter_group" "parameter_group" {
  count       = var.create_parameter_group ? 1 : 0
  name        = "${var.tags.environment}-${var.rds_instace_name}-parameter-group"
  description = var.parameter_group_description
  family      = var.parameter_group_family
  tags        = merge(var.tags, {
    Name      = "${var.tags.environment}-${var.rds_instace_name}-parameter-group"
  })

  dynamic "parameter" {
    for_each = var.parameters
    content {
      apply_method = parameter.value.apply_method
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}

resource "aws_db_option_group" "option_group" {
  count                = var.create_option_group ? 1 : 0
  name                 = "${var.tags.environment}-${var.rds_instace_name}-options-group"
  engine_name          = var.engine
  major_engine_version = var.engine_version
  tags        = merge(var.tags, {
    Name      = "${var.tags.environment}-${var.rds_instace_name}-options-group"
  })

  dynamic "option" {
    for_each = var.options
    content {
      option_name  = option.value.option_name
      option_settings {
        name  = option.value.option_setting_name
        value = option.value.option_setting_value
      }
    }
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.tags.environment}-${var.rds_instace_name}-subnet-group"
  subnet_ids = data.aws_subnets.rds_subnets.ids
  tags       = merge(var.tags, {
    Name     = "${var.tags.environment}-${var.rds_instace_name}-subnet-group"
  })
}

resource "aws_db_instance" "db_instance" {
  count                           = var.create_db_instance ? 1 : 0
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  availability_zone               = var.multi_az ? null : "${var.aws_region}${var.availability_zone}"
  backup_window                   = var.backup_window
  db_name                         = var.db_name
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  multi_az                        = var.multi_az
  character_set_name              = var.character_set_name
  username                        = var.db_admin_username
  manage_master_user_password     = true
  parameter_group_name            = var.create_parameter_group ? aws_db_parameter_group.parameter_group[0].name : null
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  option_group_name               = var.create_option_group ? aws_db_option_group.option_group[0].name : null
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  apply_immediately               = var.apply_immediately
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  backup_retention_period         = var.backup_retention_period
  publicly_accessible             = var.publicly_accessible
  kms_key_id                      = var.kms_key_id
  performance_insights_enabled    = var.performance_insights_enabled
  identifier                      = var.rds_instace_name
  maintenance_window              = var.maintenance_window
  snapshot_identifier             = var.snapshot_identifier
  storage_type                    = var.storage_type
  iops                            = var.iops
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = [aws_security_group.security_group.id]
  tags = merge(var.tags, {
    Name = var.rds_instace_name
  })
}

resource "aws_db_instance" "db_instance_replica" {
  count                           = var.create_db_instance_replica ? 1 : 0
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  availability_zone               = "${data.aws_region.current.name}${var.availability_zone}"
  backup_window                   = var.backup_window
  db_name                         = var.db_name
  instance_class                  = var.instance_class
  multi_az                        = var.multi_az
  character_set_name              = var.character_set_name
  manage_master_user_password     = true
  parameter_group_name            = var.create_parameter_group ? aws_db_parameter_group.parameter_group[0].name : null
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  option_group_name               = var.create_option_group ? aws_db_option_group.option_group[0].name : null
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  apply_immediately               = var.apply_immediately
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  backup_retention_period         = var.backup_retention_period
  publicly_accessible             = var.publicly_accessible
  replicate_source_db             = var.replicate_source_db
  kms_key_id                      = var.kms_key_id
  identifier                      = var.rds_instace_name
  maintenance_window              = var.maintenance_window
  snapshot_identifier             = var.snapshot_identifier
  storage_type                    = var.storage_type
  iops                            = var.iops
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = [aws_security_group.security_group.id]
  tags       = merge(var.tags, {
    Name = var.rds_instace_name
  })
}
