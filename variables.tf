variable "aws_region" {
  type        = string
  description = "The AWS region."
  default     = null
}

variable "create_db_instance" {
  type        = bool
  description = "Creates a RDS instance which is isolated.  Don't use with var.is_db_cluster."
  default     = false
}

variable "create_db_instance_replica" {
  type        = bool
  description = "Creates a RDS read replica."
  default     = false
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in gibibytes. If max_allocated_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs."
  default     = 20
}

variable "db_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance."
  default     = null
}

variable "db_port" {
  type        = number
  description = "The port number for database and security group policy."
  default     = null
}

variable "db_admin_username" {
  type        = string
  description = "The username of the RDS instance administrator."
  default     = null
}

variable "engine" {
  type        = string
  description = "The database engine to use.  https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10)."
  default     = null
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance."
  default     = null
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created."
  default     = false
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible."
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  default     = false
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Must be between 0 and 35."
  default     = 7
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN."
  default     = null
}

variable "availability_zone" {
  type        = string
  description = "The AZ for the RDS instance."
  default     = null
}

variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'."
  default     = null
}

variable "character_set_name" {
  type        = string
  description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances (collation). This can't be changed."
  default     = null
}

variable "rds_instace_name" {
  type        = string
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier. Required if restore_to_point_in_time is specified."
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'."
  default     = null
}

variable "tags" {
  type        = map
  description = "A map of tags"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of a VPC for the subnet group and security group."
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = null
}

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (general purpose SSD that needs iops independently) or 'io1' (provisioned IOPS SSD)."
  default     = "gp3"
}

variable "max_allocated_storage" {
  type        = number
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated_storage. Must be greater than or equal to allocated_storage or 0 to disable Storage Autoscaling."
  default     = null
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN."
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ."
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true."
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(any)
  description = "Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine). MySQL and MariaDB: audit, error, general, slowquery. PostgreSQL: postgresql, upgrade. MSSQL: agent , error. Oracle: alert, audit, listener, trace."
  default     = null
}

variable "iops" {
  type        = number
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'. Can only be set when storage_type is 'io1' or 'gp3'."
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible."
  default     = false
}

variable "subnet_group_name" {
  type        = string
  description = "A name for the RDS subnet group."
  default     = null
}

variable "parameter_group_name" {
  type        = string
  description = "A name for the RDS parameter group."
  default     = null
}

variable "parameter_group_description" {
  type        = string
  description = "A description for the RDS parameter group."
  default     = null
}

variable "parameter_group_family" {
  type        = string
  description = "The family of the DB parameter group."
  default     = null
}

variable "create_parameter_group" {
  type        = bool
  description = "Creates a RDS parameter group."
  default     = false
}

variable "create_option_group" {
  type        = bool
  description = "Creates a RDS option group."
  default     = false
}

variable "parameters" {
  type        = list(map(string))
  default     = []
}

variable "options" {
  type        = list(map(any))
  default     = []
}

variable "replicate_source_db" {
  type        = string
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate (if replicating within a single region) or ARN of the Amazon RDS Database to replicate (if replicating cross-region). Note that if you are creating a cross-region replica of an encrypted database you will also need to specify a kms_key_id."
  default     = null
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Specifies whether Performance Insights are enabled."
  default     = false
}
