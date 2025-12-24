# Architecture Documentation

## Overview

This document provides detailed architecture documentation for the AWS Landing Zone implementation.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         AWS Landing Zone                         │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                    Security & Compliance                   │  │
│  │                                                             │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌──────────────────┐  │  │
│  │  │ CloudTrail  │  │ AWS Config  │  │  IAM Roles       │  │  │
│  │  │  (Audit)    │  │ (Compliance)│  │  (Least Priv)    │  │  │
│  │  └─────────────┘  └─────────────┘  └──────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                    Network Architecture                    │  │
│  │                                                             │  │
│  │  ┌─────────────────────────────────────────────────────┐  │  │
│  │  │               VPC (10.0.0.0/16)                      │  │  │
│  │  │                                                       │  │  │
│  │  │  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │  │  │
│  │  │  │   AZ-1       │  │   AZ-2       │  │   AZ-3     │ │  │  │
│  │  │  │              │  │              │  │            │ │  │  │
│  │  │  │  Public      │  │  Public      │  │  Public    │ │  │  │
│  │  │  │  10.0.0.0/24 │  │  10.0.1.0/24 │  │ 10.0.2.0/24│ │  │  │
│  │  │  │  ┌────────┐  │  │  ┌────────┐  │  │ ┌────────┐ │ │  │  │
│  │  │  │  │  NAT   │  │  │  │  NAT   │  │  │ │  NAT   │ │ │  │  │
│  │  │  │  │Gateway │  │  │  │Gateway │  │  │ │Gateway │ │ │  │  │
│  │  │  │  └────────┘  │  │  └────────┘  │  │ └────────┘ │ │  │  │
│  │  │  │              │  │              │  │            │ │  │  │
│  │  │  │  Private     │  │  Private     │  │  Private   │ │  │  │
│  │  │  │ 10.0.10.0/24 │  │ 10.0.11.0/24 │  │10.0.12.0/24│ │  │  │
│  │  │  │              │  │              │  │            │ │  │  │
│  │  │  │  Database    │  │  Database    │  │  Database  │ │  │  │
│  │  │  │ 10.0.20.0/24 │  │ 10.0.21.0/24 │  │10.0.22.0/24│ │  │  │
│  │  │  └──────────────┘  └──────────────┘  └────────────┘ │  │  │
│  │  └─────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                    Storage & Logging                       │  │
│  │                                                             │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌──────────────────┐  │  │
│  │  │ CloudTrail  │  │ Config Logs │  │  VPC Flow Logs   │  │  │
│  │  │  S3 Bucket  │  │  S3 Bucket  │  │  S3 Bucket       │  │  │
│  │  │ (7yr retention)│(7yr retention)│ (1yr retention)   │  │  │
│  │  └─────────────┘  └─────────────┘  └──────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Network Architecture Details

### VPC Structure
- **CIDR Block**: 10.0.0.0/16 (customizable)
- **Availability Zones**: 2-6 (default: 2)
- **Subnet Types**: Public, Private, Database

### Subnet Allocation
- **Public Subnets**: 10.0.0.0/24, 10.0.1.0/24, etc.
  - Internet-facing resources
  - NAT Gateways
  - Load balancers
  
- **Private Subnets**: 10.0.10.0/24, 10.0.11.0/24, etc.
  - Application servers
  - Container workloads
  - Lambda functions
  
- **Database Subnets**: 10.0.20.0/24, 10.0.21.0/24, etc.
  - RDS instances
  - ElastiCache
  - Other data stores

### Routing

#### Public Route Table
- Default route (0.0.0.0/0) → Internet Gateway
- Associated with all public subnets

#### Private Route Tables
- Default route (0.0.0.0/0) → NAT Gateway
- One per AZ (HA mode) or shared (cost-optimized)
- Associated with all private subnets

#### Database Route Table
- No default route (no internet access)
- Local VPC routes only
- Associated with all database subnets

## Security Architecture

### IAM Roles

#### CloudTrail Service Role
- **Purpose**: Allow CloudTrail to write logs to CloudWatch
- **Permissions**: CreateLogStream, PutLogEvents
- **Trust Policy**: cloudtrail.amazonaws.com

#### AWS Config Service Role
- **Purpose**: Allow Config to record configurations
- **Permissions**: AWS managed ConfigRole policy
- **Additional**: S3 write access for Config bucket

#### VPC Flow Logs Role
- **Purpose**: Allow Flow Logs to write to CloudWatch
- **Permissions**: CreateLogGroup, CreateLogStream, PutLogEvents

#### Developer Role
- **Purpose**: Limited development access
- **Permissions**: 
  - EC2 read-only
  - S3 limited access (prefixed resources only)
  - CloudWatch Logs read
- **Assumption**: Specific IAM users/roles

#### ReadOnly Role
- **Purpose**: Auditing and compliance review
- **Permissions**: AWS managed ReadOnlyAccess
- **Assumption**: Specific IAM users/roles

### Compliance Monitoring

AWS Config rules monitor:
1. **Storage Security**
   - S3 bucket versioning
   - S3 bucket encryption
   - EBS volume encryption
   - RDS storage encryption

2. **Access Control**
   - IAM password policy
   - Root account MFA
   - IAM user MFA
   - SSH access restrictions

3. **Audit & Logging**
   - CloudTrail enablement
   - VPC Flow Logs enablement

## Data Flow

### Audit Log Flow
```
AWS API Call → CloudTrail → S3 Bucket (Encrypted)
                    ↓
            CloudWatch Logs (Optional)
```

### Configuration Tracking Flow
```
Resource Change → AWS Config → Configuration Recorder
                                      ↓
                              S3 Bucket (Encrypted)
                                      ↓
                              Config Rules Evaluation
```

### Network Traffic Flow
```
VPC Traffic → Flow Logs → S3 Bucket (Encrypted)
```

## High Availability

### Multi-AZ Design
- Resources deployed across multiple availability zones
- NAT Gateways in each AZ (HA mode) or single (cost mode)
- Subnet redundancy for all tiers

### Failure Scenarios

#### Single NAT Gateway Mode
- **Risk**: NAT Gateway failure affects all private subnets
- **Mitigation**: Use multi-NAT mode for production

#### Multi-NAT Gateway Mode
- **Risk**: AZ-level NAT failure affects only that AZ
- **Mitigation**: Automatic routing to other AZs

## Cost Optimization

### Development/Testing
- Single NAT Gateway: ~$32/month
- 2 Availability Zones
- Shorter log retention periods
- Less frequent Config snapshots

### Production
- NAT Gateway per AZ: ~$32/month each
- 3+ Availability Zones
- 7-year log retention (compliance)
- Frequent Config snapshots

## Security Considerations

### Data Encryption
- **At Rest**: All S3 buckets use AES-256 encryption
- **In Transit**: HTTPS/TLS for all API calls
- **Key Management**: AWS managed keys (upgradable to KMS)

### Access Control
- **S3 Buckets**: Public access blocked
- **IAM Roles**: Least-privilege principles
- **Network**: Private subnets isolated from internet

### Monitoring
- **CloudTrail**: All API calls logged
- **Config**: Continuous compliance monitoring
- **Flow Logs**: Network traffic analysis

## Scalability

### Horizontal Scaling
- Add more availability zones
- Additional subnets as needed
- Multiple NAT Gateways

### Vertical Scaling
- Larger VPC CIDR blocks
- More IP addresses per subnet
- Additional Config rules

## Integration Points

### External Systems
- AWS Organizations (multi-account)
- AWS SSO (identity federation)
- Third-party SIEM tools (log forwarding)
- Infrastructure monitoring (CloudWatch)

### Terraform State
- Remote state in S3
- State locking with DynamoDB
- Encrypted state files

## Maintenance

### Regular Tasks
- Review CloudTrail logs
- Monitor Config compliance
- Update IAM policies
- Rotate credentials
- Apply Terraform updates

### Disaster Recovery
- S3 bucket versioning enabled
- Multi-region replication (optional)
- Terraform state backups
- Configuration documentation

## Future Enhancements

Potential additions:
- AWS WAF for application protection
- GuardDuty for threat detection
- Security Hub for centralized security
- AWS Systems Manager for patch management
- AWS Backup for automated backups
- Transit Gateway for multi-VPC connectivity
