# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "IDs of database subnets"
  value       = module.vpc.database_subnet_ids
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

# S3 Outputs
output "cloudtrail_bucket_id" {
  description = "ID of CloudTrail logs bucket"
  value       = module.s3.cloudtrail_bucket_id
}

output "config_bucket_id" {
  description = "ID of AWS Config logs bucket"
  value       = module.s3.config_bucket_id
}

output "flow_logs_bucket_id" {
  description = "ID of VPC Flow Logs bucket"
  value       = module.s3.flow_logs_bucket_id
}

# IAM Outputs
output "cloudtrail_role_arn" {
  description = "ARN of CloudTrail IAM role"
  value       = module.iam.cloudtrail_role_arn
}

output "config_role_arn" {
  description = "ARN of AWS Config IAM role"
  value       = module.iam.config_role_arn
}

output "developer_role_arn" {
  description = "ARN of developer IAM role"
  value       = module.iam.developer_role_arn
}

output "readonly_role_arn" {
  description = "ARN of read-only IAM role"
  value       = module.iam.readonly_role_arn
}

# CloudTrail Outputs
output "cloudtrail_id" {
  description = "ID of the CloudTrail"
  value       = var.enable_cloudtrail ? module.cloudtrail[0].cloudtrail_id : null
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail"
  value       = var.enable_cloudtrail ? module.cloudtrail[0].cloudtrail_arn : null
}

# AWS Config Outputs
output "config_recorder_id" {
  description = "ID of AWS Config Configuration Recorder"
  value       = var.enable_config ? module.config[0].configuration_recorder_id : null
}

output "config_rules" {
  description = "List of AWS Config rule names"
  value       = var.enable_config ? module.config[0].config_rules : []
}
