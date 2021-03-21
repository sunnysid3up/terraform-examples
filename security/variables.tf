variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "db_port" {
  default = 3306
}

variable "app_port" {
  type = number
  default = 8080
}

variable "web_port" {
  type = number
  default = 80
}

variable "public_subnets_cidr_blocks" {
  type = list(string)
}

variable "private_subnets_cidr_blocks" {
  type = list(string)
}



