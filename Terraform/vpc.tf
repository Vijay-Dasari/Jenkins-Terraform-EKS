provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "availability" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "my-vpc"
  azs = data.aws_availability_zones.availability.names
  cidr = var.my_cidr
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

}