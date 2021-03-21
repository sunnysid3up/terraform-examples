variable "name" {
  default = "fork"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "tags" {
  type = map(string)
  default = { Name = "fork" }
}