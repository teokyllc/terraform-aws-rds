output "db_instance_id" {
  value = var.create_db_instance ? aws_db_instance.db_instance[0].id : null
}

output "db_instance_arn" {
  value = var.create_db_instance ? aws_db_instance.db_instance[0].arn : null
}

output "db_instance_address" {
  value = var.create_db_instance ? aws_db_instance.db_instance[0].address : null
}

output "db_instance_port" {
  value = var.create_db_instance ? aws_db_instance.db_instance[0].port : null
}

output "db_replica_id" {
  value = var.create_db_instance_replica ? aws_db_instance.db_instance_replica[0].id : null
}

output "db_replica_arn" {
  value = var.create_db_instance_replica ? aws_db_instance.db_instance_replica[0].arn : null
}

output "db_replica_address" {
  value = var.create_db_instance_replica ? aws_db_instance.db_instance_replica[0].address : null
}

output "db_options_group_id" {
  value = var.create_option_group ? aws_db_option_group.option_group[0].id : null
}

output "db_options_group_arn" {
  value = var.create_option_group ? aws_db_option_group.option_group[0].arn : null
}

output "db_parameters_group_id" {
  value = var.create_parameter_group ? aws_db_parameter_group.parameter_group[0].id : null
}

output "db_parameters_group_arn" {
  value = var.create_parameter_group ? aws_db_parameter_group.parameter_group[0].arn : null
}

output "db_proxy_arn" {
  value = var.create_db_proxy ? aws_db_proxy.proxy[0].arn : null
}

output "db_proxy_endpoint" {
  value = var.create_db_proxy ? aws_db_proxy.proxy[0].endpoint : null
}

output "db_rds_credentials_arn" {
  value = var.create_db_proxy ? aws_secretsmanager_secret.rds_credentials.arn : null
}
