variable "region" {
  default = "eu-west-2"
}
variable "vpc_cidr" {
  default = "172.16.0.0/16"
}
variable "enable_dns_support" {
  default = "true"
}
variable "enable_dns_hostnames" {
  default = "true"
}
variable "preferred_number_of_public_subnets" {
  default = 2
}
variable "preferred_number_of_private_subnets" {
  default = 2
}
provider "aws" {
  region = var.region
}
variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type = map(string)
  default = {}
}
variable "name" {  
  type = string
  default = "ACS"
}

variable "environment" {
  type = string
  description = "Environment"
}