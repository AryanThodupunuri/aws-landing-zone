variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "config_role_arn" {
  description = "IAM role ARN for AWS Config"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for AWS Config logs"
  type        = string
}

variable "delivery_frequency" {
  description = "Delivery frequency for AWS Config snapshots"
  type        = string
  default     = "Six_Hours"

  validation {
    condition     = contains(["One_Hour", "Three_Hours", "Six_Hours", "Twelve_Hours", "TwentyFour_Hours"], var.delivery_frequency)
    error_message = "Delivery frequency must be one of: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, TwentyFour_Hours."
  }
}

variable "enable_config_rules" {
  description = "Enable AWS Config managed rules"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
