provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"

  project_name          = "two-tier"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones    = ["us-east-1a", "us-east-1b"]
}

module "alb" {
  source             = "../../modules/alb"
  project_name       = "two-tier"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  ec2_sg_id          = module.ec2.ec2_sg_id
}

module "ec2" {
  source             = "../../modules/ec2"
  project_name       = "two-tier"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_sg_id          = module.alb.alb_sg_id
  target_group_arn   = module.alb.target_group_arn
}

module "rds" {
  source             = "../../modules/rds"
  project_name       = "two-tier"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_sg_id          = module.ec2.ec2_sg_id
}

module "cloudfront" {
  source       = "../../modules/cloudfront"
  project_name = "two-tier"
  alb_dns_name = module.alb.alb_dns_name
}
