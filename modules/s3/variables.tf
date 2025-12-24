variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "enable_cloudtrail_bucket" {
  description = "Create S3 bucket for CloudTrail logs"
  type        = bool
  default     = true
}

variable "enable_config_bucket" {
  description = "Create S3 bucket for AWS Config logs"
  type        = bool
  default     = true
}

variable "enable_flow_logs_bucket" {
  description = "Create S3 bucket for VPC Flow Logs"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
