module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.db_identifier

  engine            = "mysql"
  engine_version    = "5.7.31"
  instance_class    = "db.t2.micro"
  allocated_storage = var.db_allocated_storage

  name = var.name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  vpc_security_group_ids = [var.db_sg]

  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window

  # disable backups to create DB faster
  backup_retention_period = var.db_backup_retention_period

  # disable
  skip_final_snapshot = true

  subnet_ids = var.database_subnets

  family = "mysql5.7"
  major_engine_version = "5.7"

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = var.tags
}