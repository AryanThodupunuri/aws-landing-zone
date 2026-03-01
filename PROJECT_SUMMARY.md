Project summary
This project implements an AWS Landing Zone using Terraform. It focuses on modularity, security guardrails, and developer workflows (plan-only demo artifacts + CI checks) so reviewers can validate infra without cloud access.

Technical highlights
- Reusable Terraform modules: VPC, IAM, S3, CloudTrail, account configuration
- CI pipeline to run `terraform fmt -check`, `terraform validate`, `tflint`, and `tfsec`
- Demo artifacts: sanitized Terraform plan JSON and architecture diagram for inspection
- Optional test harness using Terratest (example included)

Resume-ready bullets (pick and adapt)
- "Designed and implemented a modular AWS Landing Zone using Terraform, including centralized CloudTrail and IAM guardrails; created reproducible plan artifacts and CI-based static security scans (tfsec/tflint)."
- "Built reusable modules (VPC, IAM, S3, CloudTrail) and automated PR checks that generate sanitized Terraform plan JSON artifacts for code review without cloud access."
- "Authored architecture documentation and demo artifacts to enable reviewers to inspect planned infra securely and quickly."