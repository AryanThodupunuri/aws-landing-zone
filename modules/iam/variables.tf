variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "enable_cloudtrail_role" {
  description = "Create CloudTrail IAM role"
  type        = bool
  default     = true
}

variable "enable_config_role" {
  description = "Create AWS Config IAM role"
  type        = bool
  default     = true
}

variable "enable_flow_logs_role" {
  description = "Create VPC Flow Logs IAM role"
  type        = bool
  default     = true
}

variable "enable_developer_role" {
  description = "Create developer IAM role"
  type        = bool
  default     = true
}

variable "enable_readonly_role" {
  description = "Create read-only IAM role"
  type        = bool
  default     = true
}

variable "config_s3_bucket_name" {
  description = "S3 bucket name for AWS Config"
  type        = string
  default     = ""
}

variable "developer_role_principals" {
  description = "List of AWS principals allowed to assume developer role"
  type        = list(string)
  default     = []
}

variable "readonly_role_principals" {
  description = "List of AWS principals allowed to assume readonly role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
