# AWS Landing Zone

Terraform-based AWS Landing Zone for secure, scalable multi-account setup. This infrastructure provides a production-ready foundation for compliant development and testing environments.

## Overview

This AWS Landing Zone implementation provides:

- **VPC with Subnet Isolation**: Separate public, private, and database subnets across multiple availability zones
- **NAT Gateways**: Secure internet access for private subnets
- **IAM Least-Privilege Roles**: Pre-configured roles with minimal permissions
- **CloudTrail Logging**: Comprehensive audit logging of all API calls
- **AWS Config Rules**: Continuous compliance monitoring
- **S3 Log Archival**: Encrypted, versioned buckets with lifecycle policies

## Architecture

### Network Architecture
- **VPC**: Isolated network with customizable CIDR block
- **Public Subnets**: Internet-facing resources with Internet Gateway
- **Private Subnets**: Application tier with NAT Gateway access
- **Database Subnets**: Isolated data tier with no internet access
- **Multi-AZ**: High availability across 2-6 availability zones

### Security & Compliance
- **CloudTrail**: Multi-region trail with log file validation
- **AWS Config**: Configuration recorder with 10+ managed rules
- **VPC Flow Logs**: Network traffic monitoring
- **S3 Encryption**: Server-side encryption for all log buckets
- **IAM Roles**: Least-privilege access patterns

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS Account with appropriate permissions
- AWS CLI configured with credentials

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/AryanThodupunuri/aws-landing-zone.git
   cd aws-landing-zone
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Create your configuration**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your settings
   ```

4. **Review the plan**
   ```bash
   terraform plan
   ```

5. **Deploy the infrastructure**
   ```bash
   terraform apply
   ```

## Configuration

### Basic Configuration

The minimum configuration requires setting your AWS region and name prefix:

```hcl
aws_region  = "us-east-1"
name_prefix = "my-org-lz"
```

### Network Configuration

Customize your VPC and subnet layout:

```hcl
vpc_cidr                     = "10.0.0.0/16"
number_of_availability_zones = 2
enable_nat_gateway           = true
single_nat_gateway           = false
enable_vpc_flow_logs         = true
```

### Security & Compliance

Enable/disable security features:

```hcl
enable_cloudtrail                 = true
enable_cloudtrail_cloudwatch_logs = true
cloudtrail_log_retention_days     = 90

enable_config               = true
enable_config_rules         = true
config_delivery_frequency   = "Six_Hours"
```

### IAM Roles

Configure least-privilege roles:

```hcl
enable_developer_role     = true
enable_readonly_role      = true
developer_role_principals = ["arn:aws:iam::123456789012:user/developer"]
readonly_role_principals  = ["arn:aws:iam::123456789012:user/auditor"]
```

**Note**: Developer and read-only roles will only be created if you provide at least one principal ARN. If you don't need these roles immediately, you can omit the `developer_role_principals` and `readonly_role_principals` variables.

## Modules

### VPC Module (`modules/vpc`)
Creates a VPC with:
- Public, private, and database subnets
- Internet Gateway and NAT Gateways
- Route tables and associations
- VPC Flow Logs (optional)

### IAM Module (`modules/iam`)
Creates IAM roles for:
- CloudTrail service
- AWS Config service
- VPC Flow Logs
- Developer access (least-privilege)
- Read-only access (auditing)

### S3 Module (`modules/s3`)
Creates encrypted S3 buckets for:
- CloudTrail logs (7-year retention)
- AWS Config logs (7-year retention)
- VPC Flow Logs (1-year retention)

### CloudTrail Module (`modules/cloudtrail`)
Configures:
- Multi-region trail
- S3 and CloudWatch Logs integration
- Log file validation
- Insights for API call rate anomalies

### Config Module (`modules/config`)
Implements:
- Configuration recorder
- Delivery channel to S3
- 10+ managed compliance rules

## Outputs

After deployment, the following outputs are available:

- `vpc_id`: VPC identifier
- `public_subnet_ids`: Public subnet identifiers
- `private_subnet_ids`: Private subnet identifiers
- `database_subnet_ids`: Database subnet identifiers
- `cloudtrail_bucket_id`: CloudTrail logs bucket
- `config_bucket_id`: AWS Config logs bucket
- `developer_role_arn`: Developer role ARN
- `readonly_role_arn`: Read-only role ARN

## Cost Optimization

For development/testing environments, reduce costs by:

1. **Single NAT Gateway**: Set `single_nat_gateway = true`
2. **Fewer AZs**: Use `number_of_availability_zones = 2`
3. **Disable features**: Set `enable_vpc_flow_logs = false` if not needed

## Best Practices

1. **Remote State**: Configure S3 backend for state management
2. **State Locking**: Use DynamoDB for concurrent access protection
3. **Tagging**: Customize `default_tags` for resource organization
4. **Secrets**: Never commit `terraform.tfvars` to version control
5. **Compliance**: Review AWS Config rules regularly

## Security Considerations

- All S3 buckets have versioning and encryption enabled
- Public access is blocked on all log buckets
- IAM roles follow least-privilege principles
- CloudTrail log file validation is enabled
- VPC Flow Logs capture all network traffic

## Compliance

The AWS Config rules monitor compliance with:
- S3 bucket encryption and versioning
- IAM password policies
- MFA enforcement
- CloudTrail enablement
- EBS and RDS encryption
- VPC Flow Logs
- Security group restrictions

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For issues, questions, or contributions, please open an issue on GitHub.

## Acknowledgments

Built with best practices from:
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
