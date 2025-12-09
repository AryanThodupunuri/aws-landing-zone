variable "aws_region" {
  description = "AWS region for the landing zone"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "aws-lz"
}

variable "number_of_availability_zones" {
  description = "Number of availability zones to use"
  type        = number
  default     = 2

  validation {
    condition     = var.number_of_availability_zones >= 2 && var.number_of_availability_zones <= 6
    error_message = "Number of availability zones must be between 2 and 6."
  }
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all AZs (cost optimization)"
  type        = bool
  default     = false
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

# CloudTrail Configuration
variable "enable_cloudtrail" {
  description = "Enable CloudTrail for audit logging"
  type        = bool
  default     = true
}

variable "enable_cloudtrail_cloudwatch_logs" {
  description = "Enable CloudWatch Logs integration for CloudTrail"
  type        = bool
  default     = true
}

variable "cloudtrail_log_retention_days" {
  description = "Number of days to retain CloudTrail logs in CloudWatch"
  type        = number
  default     = 90

  validation {
    condition     = var.cloudtrail_log_retention_days >= 1 && var.cloudtrail_log_retention_days <= 3653
    error_message = "CloudTrail log retention days must be between 1 and 3653 (10 years)."
  }
}

# AWS Config Configuration
variable "enable_config" {
  description = "Enable AWS Config for compliance monitoring"
  type        = bool
  default     = true
}

variable "enable_config_rules" {
  description = "Enable AWS Config managed rules"
  type        = bool
  default     = true
}

variable "config_delivery_frequency" {
  description = "Delivery frequency for AWS Config snapshots"
  type        = string
  default     = "Six_Hours"

  validation {
    condition     = contains(["One_Hour", "Three_Hours", "Six_Hours", "Twelve_Hours", "TwentyFour_Hours"], var.config_delivery_frequency)
    error_message = "Config delivery frequency must be one of: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, TwentyFour_Hours."
  }
}

# IAM Configuration
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

# Default Tags
variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Environment = "Production"
    Project     = "AWS-Landing-Zone"
  }
}
