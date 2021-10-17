provider "aws" {
  region = "eu-west-3"
}

variable "subnet-cidr-block" {
  description = "subnet cird block"
  default = "10.0.10.0/24"
  type = string
}

variable "vpc-cidr-block" {
  description = "vpc cird block"
}

variable "environment" {
  description = "deployment env"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    "Name" = var.environment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet-cidr-block
  availability_zone = "eu-west-3a"
  tags = {
    "Name" = "subnet-1-dev"
  }
}

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "eu-west-3a"
  tags = {
    "Name" = "subnet-2-dev"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}