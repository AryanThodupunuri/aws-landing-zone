# Complete AWS Landing Zone Example

This example demonstrates a full deployment of the AWS Landing Zone with all features enabled.

## Features Included

- Multi-AZ VPC with 3 availability zones
- NAT Gateway in each AZ for high availability
- VPC Flow Logs enabled
- CloudTrail with CloudWatch Logs integration
- AWS Config with all managed rules enabled
- Developer and read-only IAM roles

## Usage

1. Navigate to this directory:
   ```bash
   cd examples/complete
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the configuration in `main.tf`

4. Create a `terraform.tfvars` file:
   ```bash
   cp ../../terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your settings
   ```

5. Deploy:
   ```bash
   terraform plan
   terraform apply
   ```

## Cost Estimate

This configuration will create resources that incur costs:
- NAT Gateways: ~$0.045/hour × 3 = ~$97/month
- VPC Flow Logs: Based on data processed
- CloudTrail: First trail is free
- AWS Config: Based on configuration items and rules
- S3 Storage: Based on log volume

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

**Note**: S3 buckets with versioning may require manual cleanup if they contain objects.
