variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
}

variable "enable_cloudwatch_logs" {
  description = "Enable CloudWatch Logs for CloudTrail"
  type        = bool
  default     = true
}

variable "cloudwatch_logs_role_arn" {
  description = "IAM role ARN for CloudTrail CloudWatch Logs"
  type        = string
  default     = ""
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
