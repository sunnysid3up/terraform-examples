variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

# From VPC Module from Terraform Module Repository:
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.10.0.0/16"
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = ["10.10.3.0/24", "10.10.4.0/24"]
}

variable "vpc_database_subnets" {
  type        = list(string)
  description = "A list of database subnets"
  default     = ["10.10.5.0/24", "10.10.6.0/24"]
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "vpc_one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  default     = true
}