# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take the security of AWS Landing Zone seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Where to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via:
1. GitHub Security Advisories (preferred)
2. Email to the repository maintainers

### What to Include

Please include the following information:
- Type of vulnerability
- Full paths of source file(s) related to the vulnerability
- Location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the vulnerability

### Response Timeline

- We will acknowledge your report within 48 hours
- We will provide a detailed response within 7 days
- We will work on a fix and release it as soon as possible
- We will keep you informed of the progress

## Security Best Practices

When using this AWS Landing Zone:

### 1. AWS Credentials
- Never commit AWS credentials to version control
- Use IAM roles and instance profiles when possible
- Rotate credentials regularly

### 2. Terraform State
- Store state files in encrypted S3 buckets
- Enable versioning on state buckets
- Use state locking with DynamoDB
- Never commit state files to version control

### 3. Secrets Management
- Use AWS Secrets Manager or Parameter Store for secrets
- Never hardcode secrets in Terraform files
- Use terraform.tfvars for environment-specific values (and gitignore it)

### 4. Network Security
- Review security group rules carefully
- Follow principle of least privilege
- Enable VPC Flow Logs for monitoring
- Use private subnets for sensitive resources

### 5. Compliance
- Regularly review AWS Config compliance reports
- Monitor CloudTrail logs for unusual activity
- Enable MFA for all IAM users
- Follow CIS AWS Foundations Benchmark

### 6. Updates
- Keep Terraform and AWS provider versions up to date
- Monitor for security advisories
- Apply security patches promptly

## Known Security Considerations

1. **S3 Bucket Names**: S3 bucket names include the AWS account ID by default. While this helps ensure uniqueness, be aware that bucket names are publicly visible.

2. **IAM Roles**: The default IAM roles follow least-privilege principles, but you should review and adjust them based on your specific requirements.

3. **NAT Gateways**: When using a single NAT Gateway for cost optimization, be aware this creates a single point of failure.

4. **VPC Flow Logs**: While enabled by default, flow logs generate costs based on data processed. Monitor usage accordingly.

## Compliance Frameworks

This landing zone helps with compliance for:
- CIS AWS Foundations Benchmark
- AWS Well-Architected Framework
- NIST Cybersecurity Framework

However, you are responsible for ensuring your specific use case meets all regulatory requirements.

## Security Updates

Security updates will be released as patch versions (x.x.X) and announced via:
- GitHub Releases
- Security Advisories

Subscribe to repository notifications to stay informed.
