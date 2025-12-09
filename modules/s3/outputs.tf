output "cloudtrail_bucket_id" {
  description = "ID of CloudTrail logs bucket"
  value       = var.enable_cloudtrail_bucket ? aws_s3_bucket.cloudtrail_logs[0].id : ""
}

output "cloudtrail_bucket_arn" {
  description = "ARN of CloudTrail logs bucket"
  value       = var.enable_cloudtrail_bucket ? aws_s3_bucket.cloudtrail_logs[0].arn : ""
}

output "config_bucket_id" {
  description = "ID of AWS Config logs bucket"
  value       = var.enable_config_bucket ? aws_s3_bucket.config_logs[0].id : ""
}

output "config_bucket_arn" {
  description = "ARN of AWS Config logs bucket"
  value       = var.enable_config_bucket ? aws_s3_bucket.config_logs[0].arn : ""
}

output "flow_logs_bucket_id" {
  description = "ID of VPC Flow Logs bucket"
  value       = var.enable_flow_logs_bucket ? aws_s3_bucket.flow_logs[0].id : ""
}

output "flow_logs_bucket_arn" {
  description = "ARN of VPC Flow Logs bucket"
  value       = var.enable_flow_logs_bucket ? aws_s3_bucket.flow_logs[0].arn : ""
}
