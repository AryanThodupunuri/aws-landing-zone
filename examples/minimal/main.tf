# Minimal AWS Landing Zone Example (Cost-Optimized)

module "aws_landing_zone" {
  source = "../../"

  # AWS Configuration
  aws_region  = "us-east-1"
  name_prefix = "minimal-lz"

  # VPC Configuration - Cost optimized with single NAT Gateway
  vpc_cidr                     = "10.0.0.0/16"
  number_of_availability_zones = 2
  enable_nat_gateway           = true
  single_nat_gateway           = true # Single NAT Gateway for cost savings
  enable_vpc_flow_logs         = true

  # CloudTrail Configuration
  enable_cloudtrail                 = true
  enable_cloudtrail_cloudwatch_logs = true
  cloudtrail_log_retention_days     = 30 # Shorter retention for dev/test

  # AWS Config Configuration
  enable_config             = true
  enable_config_rules       = true
  config_delivery_frequency = "TwentyFour_Hours" # Less frequent for cost savings

  # IAM Roles
  enable_developer_role = true
  enable_readonly_role  = true

  # Tags
  default_tags = {
    ManagedBy   = "Terraform"
    Environment = "Development"
    Project     = "AWS-Landing-Zone-Minimal-Example"
    Example     = "Minimal"
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
