# AWS Config Module - Compliance monitoring and configuration tracking

resource "aws_config_configuration_recorder" "main" {
  name     = "${var.name_prefix}-recorder"
  role_arn = var.config_role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "${var.name_prefix}-delivery-channel"
  s3_bucket_name = var.s3_bucket_name

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.main]
}

# AWS Config Rules for Compliance

# Ensure S3 buckets have versioning enabled
resource "aws_config_config_rule" "s3_bucket_versioning_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-s3-bucket-versioning-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure S3 buckets are encrypted
resource "aws_config_config_rule" "s3_bucket_server_side_encryption_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-s3-bucket-sse-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure CloudTrail is enabled
resource "aws_config_config_rule" "cloudtrail_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-cloudtrail-enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure IAM password policy is compliant
resource "aws_config_config_rule" "iam_password_policy" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-iam-password-policy"

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }

  input_parameters = jsonencode({
    RequireUppercaseCharacters = true
    RequireLowercaseCharacters = true
    RequireSymbols             = true
    RequireNumbers             = true
    MinimumPasswordLength      = 14
    PasswordReusePrevention    = 24
    MaxPasswordAge             = 90
  })

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure root account MFA is enabled
resource "aws_config_config_rule" "root_account_mfa_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-root-account-mfa-enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure IAM users have MFA enabled
resource "aws_config_config_rule" "iam_user_mfa_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-iam-user-mfa-enabled"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure EBS volumes are encrypted
resource "aws_config_config_rule" "encrypted_volumes" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-encrypted-volumes"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure VPC flow logging is enabled
resource "aws_config_config_rule" "vpc_flow_logs_enabled" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-vpc-flow-logs-enabled"

  source {
    owner             = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure security groups don't allow unrestricted incoming traffic
resource "aws_config_config_rule" "restricted_ssh" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-restricted-ssh"

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# Ensure RDS instances are encrypted
resource "aws_config_config_rule" "rds_storage_encrypted" {
  count = var.enable_config_rules ? 1 : 0
  name  = "${var.name_prefix}-rds-storage-encrypted"

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}
