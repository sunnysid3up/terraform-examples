data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

module "network" {
  source = "./network"
  name = var.name
  tags = var.tags
}

module "security" {
  source = "./security"
  name = var.name
  tags = var.tags
  vpc_id = module.network.vpc_id
  public_subnets_cidr_blocks = module.network.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = module.network.private_subnets_cidr_blocks
}

module "rds" {
  source = "./rds"
  name = var.name
  tags = var.tags
  vpc_id = module.network.vpc_id
  db_sg = module.security.db_sg
  private_subnets_cidr_blocks = module.network.private_subnets_cidr_blocks
  database_subnets = module.network.database_subnets
}

module "compute" {
  source = "./compute"
  name = var.name
  tags = var.tags
  image_id = data.aws_ami.amazon_linux.id
  public_subnets = module.network.public_subnets
  private_subnets = module.network.private_subnets
  app_sg = module.security.app_sg
  web_sg = module.security.web_sg
  web_alb_dns_name = module.alb.web_dns_name
}

module "alb" {
  source = "./alb"
  name = var.name
  tags = var.tags
  vpc_id = module.network.vpc_id
  app_sg = module.security.app_sg
  web_sg = module.security.web_sg
  private_subnets = module.network.private_subnets
  public_subnets = module.network.public_subnets
  instance_id = module.compute.private_instance_id
}