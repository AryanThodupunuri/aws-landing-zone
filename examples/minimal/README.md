# Minimal AWS Landing Zone Example (Cost-Optimized)

This example demonstrates a minimal deployment optimized for development/testing environments.

## Features Included

- Single NAT Gateway (shared across AZs)
- 2 availability zones
- All security features enabled
- Cost-optimized configuration

## Cost Savings

Compared to the complete example:
- Single NAT Gateway: ~$32/month vs ~$97/month
- 2 AZs instead of 3
- Same security and compliance features

## Usage

1. Navigate to this directory:
   ```bash
   cd examples/minimal
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Deploy:
   ```bash
   terraform plan
   terraform apply
   ```

## Cleanup

```bash
terraform destroy
```
