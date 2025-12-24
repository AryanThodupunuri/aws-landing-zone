output "configuration_recorder_id" {
  description = "ID of AWS Config Configuration Recorder"
  value       = aws_config_configuration_recorder.main.id
}

output "delivery_channel_id" {
  description = "ID of AWS Config Delivery Channel"
  value       = aws_config_delivery_channel.main.id
}

output "config_rules" {
  description = "List of AWS Config rule names"
  value = var.enable_config_rules ? [
    aws_config_config_rule.s3_bucket_versioning_enabled[0].name,
    aws_config_config_rule.s3_bucket_server_side_encryption_enabled[0].name,
    aws_config_config_rule.cloudtrail_enabled[0].name,
    aws_config_config_rule.iam_password_policy[0].name,
    aws_config_config_rule.root_account_mfa_enabled[0].name,
    aws_config_config_rule.iam_user_mfa_enabled[0].name,
    aws_config_config_rule.encrypted_volumes[0].name,
    aws_config_config_rule.vpc_flow_logs_enabled[0].name,
    aws_config_config_rule.restricted_ssh[0].name,
    aws_config_config_rule.rds_storage_encrypted[0].name,
  ] : []
}
