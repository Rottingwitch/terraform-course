resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_Virginia",
    name = "prueba"
    env  = "Dev"
  }
}


resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio_cidr
  tags = {
    Name = "VPC_ohio",
    name = "prueba"
    env  = "Dev"
  }
  provider = aws.ohio
}

