locals {
  region = "us-east-1"
  name   = "wolf-test"
}

provider "aws" {
  region = local.region
}

module "tgw" {
  source    = "terraform-aws-modules/transit-gateway/aws"
  version   = "~> 2.0"
  name      = "${local.name}-tgw"
  share_tgw = false

  vpc_attachments = {
    vpc1 = {
      vpc_id       = module.vpc1.vpc_id
      subnet_ids   = module.vpc1.public_subnets
      dns_support  = true
      ipv6_support = false
      tgw_routes = [{ destination_cidr_block = "10.20.0.0/16" }]
    },
    vpc2 = {
      vpc_id       = module.vpc2.vpc_id
      subnet_ids   = module.vpc2.public_subnets
      dns_support  = true
      ipv6_support = false
      tgw_routes = [{ destination_cidr_block = "10.21.0.0/16" }]
    }
  }
}

module "vpc1" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "~> 3.0"
  name           = "${local.name}-vpc1"
  cidr           = "10.20.0.0/16"
  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  enable_ipv6    = false
}

module "vpc2" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "~> 3.0"
  name           = "${local.name}-vpc2"
  cidr           = "10.21.0.0/16"
  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = ["10.21.1.0/24", "10.21.2.0/24", "10.21.3.0/24"]
  enable_ipv6    = false
}

