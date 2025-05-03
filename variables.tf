variable "prefix" {
  type = string
}

variable "region" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "vpc_cidr" {
  type = string
}

variable "subnet1_cidr" {
  type = string
}

variable "subnet2_cidr" {
  type = string
}

variable "subnet3_cidr" {
  type = string
}

variable "subnet4_cidr" {
  type = string
}

variable "subnet5_cidr" {
  type = string
}

variable "subnet6_cidr" {
  type = string
}
