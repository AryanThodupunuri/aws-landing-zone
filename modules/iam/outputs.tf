output "cloudtrail_role_arn" {
  description = "ARN of CloudTrail IAM role"
  value       = var.enable_cloudtrail_role ? aws_iam_role.cloudtrail[0].arn : ""
}

output "config_role_arn" {
  description = "ARN of AWS Config IAM role"
  value       = var.enable_config_role ? aws_iam_role.config[0].arn : ""
}

output "flow_logs_role_arn" {
  description = "ARN of VPC Flow Logs IAM role"
  value       = var.enable_flow_logs_role ? aws_iam_role.flow_logs[0].arn : ""
}

output "developer_role_arn" {
  description = "ARN of developer IAM role"
  value       = var.enable_developer_role && length(var.developer_role_principals) > 0 ? aws_iam_role.developer[0].arn : ""
}

output "readonly_role_arn" {
  description = "ARN of read-only IAM role"
  value       = var.enable_readonly_role && length(var.readonly_role_principals) > 0 ? aws_iam_role.readonly[0].arn : ""
}
