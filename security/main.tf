resource "aws_security_group" "db" {
  name = "${var.name}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_blocks
  }

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "app" {
  name = "${var.name}-app-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = concat(var.public_subnets_cidr_blocks, var.private_subnets_cidr_blocks)
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.public_subnets_cidr_blocks
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_security_group" "web" {
  name = "${var.name}-web-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = var.web_port
    to_port = var.web_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.app_port
    to_port = var.app_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}