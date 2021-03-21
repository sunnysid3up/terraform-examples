variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "image_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "app_sg" {
  type = string
}

variable "web_sg" {
  type = string
}

variable "app_port" {
  default = 8080
}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

//variable "app_alb_dns_name" {
//  type = string
//}

variable "web_alb_dns_name" {
  type = string
}

variable "app_instance_type" {
  description = "The EC2 instance type for the application servers"
  default = "t2.micro"
}

variable "app_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 2
}

variable "app_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 3
}

variable "web_instance_type" {
  description = "The EC2 instance type for the web servers"
  default = "t2.micro"
}

variable "web_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 2
}

variable "web_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 3
}
