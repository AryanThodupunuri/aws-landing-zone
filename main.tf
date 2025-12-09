# AWS Landing Zone - Root Module
# Terraform-based AWS Landing Zone for secure, scalable multi-account setup

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.default_tags
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Get available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  azs        = slice(data.aws_availability_zones.available.names, 0, var.number_of_availability_zones)
}

# S3 Buckets for Log Archival
module "s3" {
  source = "./modules/s3"

  name_prefix              = var.name_prefix
  account_id               = local.account_id
  enable_cloudtrail_bucket = var.enable_cloudtrail
  enable_config_bucket     = var.enable_config
  enable_flow_logs_bucket  = var.enable_vpc_flow_logs
  tags                     = var.default_tags
}

# IAM Roles with Least Privilege
module "iam" {
  source = "./modules/iam"

  name_prefix               = var.name_prefix
  enable_cloudtrail_role    = var.enable_cloudtrail
  enable_config_role        = var.enable_config
  enable_flow_logs_role     = var.enable_vpc_flow_logs
  enable_developer_role     = var.enable_developer_role
  enable_readonly_role      = var.enable_readonly_role
  config_s3_bucket_name     = module.s3.config_bucket_id
  developer_role_principals = var.developer_role_principals
  readonly_role_principals  = var.readonly_role_principals
  tags                      = var.default_tags
}

# VPC with Subnet Isolation
module "vpc" {
  source = "./modules/vpc"

  name_prefix               = var.name_prefix
  vpc_cidr                  = var.vpc_cidr
  availability_zones        = local.azs
  enable_nat_gateway        = var.enable_nat_gateway
  single_nat_gateway        = var.single_nat_gateway
  enable_flow_logs          = var.enable_vpc_flow_logs
  flow_logs_role_arn        = module.iam.flow_logs_role_arn
  flow_logs_destination_arn = module.s3.flow_logs_bucket_arn
  tags                      = var.default_tags
}

# CloudTrail for Audit Logging
module "cloudtrail" {
  source = "./modules/cloudtrail"
  count  = var.enable_cloudtrail ? 1 : 0

  name_prefix              = var.name_prefix
  s3_bucket_name           = module.s3.cloudtrail_bucket_id
  enable_cloudwatch_logs   = var.enable_cloudtrail_cloudwatch_logs
  cloudwatch_logs_role_arn = module.iam.cloudtrail_role_arn
  log_retention_days       = var.cloudtrail_log_retention_days
  tags                     = var.default_tags

  depends_on = [module.s3]
}

# AWS Config for Compliance Monitoring
module "config" {
  source = "./modules/config"
  count  = var.enable_config ? 1 : 0

  name_prefix         = var.name_prefix
  config_role_arn     = module.iam.config_role_arn
  s3_bucket_name      = module.s3.config_bucket_id
  delivery_frequency  = var.config_delivery_frequency
  enable_config_rules = var.enable_config_rules
  tags                = var.default_tags

  depends_on = [module.s3, module.iam]
}
