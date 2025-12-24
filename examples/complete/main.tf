# Complete AWS Landing Zone Example

module "aws_landing_zone" {
  source = "../../"

  # AWS Configuration
  aws_region  = "us-east-1"
  name_prefix = "complete-lz"

  # VPC Configuration - 3 AZs with NAT Gateway in each
  vpc_cidr                     = "10.0.0.0/16"
  number_of_availability_zones = 3
  enable_nat_gateway           = true
  single_nat_gateway           = false # NAT Gateway per AZ for HA
  enable_vpc_flow_logs         = true

  # CloudTrail Configuration
  enable_cloudtrail                 = true
  enable_cloudtrail_cloudwatch_logs = true
  cloudtrail_log_retention_days     = 90

  # AWS Config Configuration
  enable_config             = true
  enable_config_rules       = true
  config_delivery_frequency = "Six_Hours"

  # IAM Roles
  enable_developer_role = true
  enable_readonly_role  = true

  # Tags
  default_tags = {
    ManagedBy   = "Terraform"
    Environment = "Production"
    Project     = "AWS-Landing-Zone-Complete-Example"
    Example     = "Complete"
  }
}

# Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.aws_landing_zone.vpc_id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.aws_landing_zone.public_subnet_ids
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.aws_landing_zone.private_subnet_ids
}

output "database_subnets" {
  description = "Database subnet IDs"
  value       = module.aws_landing_zone.database_subnet_ids
}

output "developer_role_arn" {
  description = "Developer IAM role ARN"
  value       = module.aws_landing_zone.developer_role_arn
}

output "readonly_role_arn" {
  description = "Read-only IAM role ARN"
  value       = module.aws_landing_zone.readonly_role_arn
}
