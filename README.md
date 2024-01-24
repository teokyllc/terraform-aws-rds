# terraform-aws-rds
This is a Terraform module that creates AWS RDS DB instances and clusters.<br>
[AWS RDS](https://docs.aws.amazon.com/rds/index.html)<br>
[Terraform AWS RDS DB Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)<br>
[Terraform AWS RDS DB Cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster)<br>
[Terraform AWS RDS Subnet Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)<br>
[Terraform AWS RDS Parameter Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group)<br>
[Terraform AWS RDS Options Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group)<br>

## Using specific versions of this module
You can use versioned release tags to ensure that your project using this module does not break when this module is updated in the future.<br>

<b>Repo latest commit</b><br>
```
module "rds" {
  source = "github.com/teokyllc/terraform-aws-rds"
  ...
```
<br>

<b>Tagged release</b><br>

```
module "rds" {
  source = "github.com/teokyllc/terraform-aws-rds?ref=1.0"
  ...
```
<br>

## Examples of using this module
This is an example of using this module to create a DB instance.<br>

```
module "rds" {
  source                          = "github.com/teokyllc/terraform-aws-rds?ref=1.0"
  is_db_instance                  = true
  allocated_storage               = 20
  max_allocated_storage           = 100
  rds_instace_name                = "test"
  db_name                         = "test"
  engine                          = "mysql"
  engine_version                  = "5.7"
  instance_class                  = "db.t3.micro"
  username                        = "sqladmin"
  password                        = "P@ssw*rd!"
  publicly_accessible             = false
  apply_immediately               = false
  skip_final_snapshot             = true
  allow_major_version_upgrade     = false
  deletion_protection             = false
  backup_retention_period         = 7
  availability_zone               = "a"
  backup_window                   = "00:00-02:00"
  maintenance_window              = "Sun:02:00-Sun:05:00"
  multi_az                        = false
  rds_subnet_tier                 = "data"
  security_group_ids              = ["sg-0c40e0d2faba017ca"]
  storage_encrypted               = false
  vpc_id                          = "vpc-0eeca0e683a8b1ca5"
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  parameters = [ 
    {
      name = "character_set_connection"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]
  tags = {
    tag = "value"
  }
}


```

<br><br>
Module can be tested locally:<br>
```
git clone https://github.com/teokyllc/terraform-aws-rds.git
cd terraform-aws-rds

cat <<EOF > rds.auto.tfvars
is_db_instance                  = true
allocated_storage               = 20
max_allocated_storage           = 100
rds_instace_name                = "test"
db_name                         = "test"
engine                          = "mysql"
engine_version                  = "5.7"
instance_class                  = "db.t3.micro"
publicly_accessible             = false
apply_immediately               = false
skip_final_snapshot             = true
allow_major_version_upgrade     = false
deletion_protection             = false
backup_retention_period         = 7
availability_zone               = "a"
backup_window                   = "00:00-02:00"
maintenance_window              = "Sun:02:00-Sun:05:00"
kms_key_id                      = null
character_set_name              = null
multi_az                        = false
rds_subnet_tier                 = "data"
security_group_ids              = ["sg-0c40e0d2faba017ca"]
snapshot_identifier             = null
storage_type                    = "gp2"
iops                            = null
storage_encrypted               = false
vpc_id                          = "vpc-0eeca0e683a8b1ca5"
enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
parameters = [ 
  {
  name = "character_set_connection"
  value = "utf8"
  },
  {
  name = "character_set_server"
  value = "utf8"
  }
]
tags = {
    tag = "value"
}
EOF

terraform init
terraform apply
```