# IAM Module - Least-privilege roles and policies for AWS Landing Zone

# CloudTrail Service Role
resource "aws_iam_role" "cloudtrail" {
  count = var.enable_cloudtrail_role ? 1 : 0
  name  = "${var.name_prefix}-cloudtrail-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "cloudtrail_cloudwatch" {
  count = var.enable_cloudtrail_role ? 1 : 0
  name  = "${var.name_prefix}-cloudtrail-cloudwatch-policy"
  role  = aws_iam_role.cloudtrail[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSCloudTrailCreateLogStream"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream"
        ]
        Resource = "arn:aws:logs:*:*:log-group:*:log-stream:*"
      },
      {
        Sid    = "AWSCloudTrailPutLogEvents"
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:log-group:*:log-stream:*"
      }
    ]
  })
}

# AWS Config Service Role
resource "aws_iam_role" "config" {
  count = var.enable_config_role ? 1 : 0
  name  = "${var.name_prefix}-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "config_policy" {
  count      = var.enable_config_role ? 1 : 0
  role       = aws_iam_role.config[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/ConfigRole"
}

resource "aws_iam_role_policy" "config_s3" {
  count = var.enable_config_role && var.config_s3_bucket_name != "" ? 1 : 0
  name  = "${var.name_prefix}-config-s3-policy"
  role  = aws_iam_role.config[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketVersioning",
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.config_s3_bucket_name}",
          "arn:aws:s3:::${var.config_s3_bucket_name}/*"
        ]
      }
    ]
  })
}

# VPC Flow Logs Role
resource "aws_iam_role" "flow_logs" {
  count = var.enable_flow_logs_role ? 1 : 0
  name  = "${var.name_prefix}-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "flow_logs_cloudwatch" {
  count = var.enable_flow_logs_role ? 1 : 0
  name  = "${var.name_prefix}-flow-logs-cloudwatch-policy"
  role  = aws_iam_role.flow_logs[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

# Developer Role with least privilege
resource "aws_iam_role" "developer" {
  count = var.enable_developer_role && length(var.developer_role_principals) > 0 ? 1 : 0
  name  = "${var.name_prefix}-developer-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.developer_role_principals
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "developer" {
  count = var.enable_developer_role && length(var.developer_role_principals) > 0 ? 1 : 0
  name  = "${var.name_prefix}-developer-policy"
  role  = aws_iam_role.developer[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EC2ReadOnly"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:Get*"
        ]
        Resource = "*"
      },
      {
        Sid    = "S3LimitedAccess"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.name_prefix}-*",
          "arn:aws:s3:::${var.name_prefix}-*/*"
        ]
      },
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# ReadOnly Role for auditing
resource "aws_iam_role" "readonly" {
  count = var.enable_readonly_role && length(var.readonly_role_principals) > 0 ? 1 : 0
  name  = "${var.name_prefix}-readonly-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.readonly_role_principals
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count      = var.enable_readonly_role && length(var.readonly_role_principals) > 0 ? 1 : 0
  role       = aws_iam_role.readonly[0].name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
