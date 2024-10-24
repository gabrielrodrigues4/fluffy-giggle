variable "aws_region" {
  description = "Região utilizada para criar os recursos da AWS"
  type        = string
  nullable    = false
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  nullable    = false
}

variable "vpc_cidrblock" {
  description = "CIDR da VPC"
  type        = string
  nullable    = false
}


variable "vpc_azs" {
  description = "AZs da VPC"
  type        = set(string)
  nullable    = false
}

variable "vpc_private_subnets" {
  description = "Private Subnets da VPC"
  type        = set(string)
  nullable    = false
}

variable "vpc_public_subnets" {
  description = "Public Subnets da VPC"
  type        = set(string)
  nullable    = false
}