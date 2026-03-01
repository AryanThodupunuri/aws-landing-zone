# AWS Landing Zone (Terraform)

Elevator pitch: This repository contains a modular, production-oriented AWS Landing Zone implemented in Terraform. It provides reusable modules (VPC, IAM, S3, CloudTrail, configuration) and example configurations for a minimal and complete setup. Designed for multi-account guardrails, centralized logging, and automated PR checks.

Quick facts
- Tech: Terraform (>= 1.?.x), AWS Provider (>= 4.x)
- Modules: `modules/vpc`, `modules/iam`, `modules/s3`, `modules/cloudtrail`, `modules/config`
- Examples: `examples/minimal` (fast to plan), `examples/complete` (full layout)

Badges
[![Terraform fmt](https://img.shields.io/badge/terraform-fmt-brightgreen)](https://www.terraform.io)
[![CI](https://github.com/AryanThodupunuri/aws-landing-zone/actions/workflows/ci.yml/badge.svg)](https://github.com/AryanThodupunuri/aws-landing-zone/actions)

Quick start (plan-only, no credentials required)
```bash
# go to a small example, run plan-only (no backend)
cd examples/minimal
terraform init -backend=false
terraform fmt -recursive
terraform validate
terraform plan -out=plan.tfplan -var-file=../../terraform.tfvars.example
terraform show -json plan.tfplan > ../../demo/example-plan.json
```

Testing
- Install Go, run `go test ./tests/terratest -v` for plan-only integration tests.

What this repo demonstrates
- Modular Terraform architecture suitable for multi-account landing zones
- Secure defaults (CloudTrail, centralized logging design)
- CI workflow for formatting, validation, and static security scanning
- Reproducible example plans and demo artifacts for reviewers

Files and structure
- `modules/`: reusable modules
- `examples/`: working example configurations
- `demo/`: sanitized plan artifacts and demo scripts (see `demo/README.md`)
- `ARCHITECTURE.md` - architecture overview and diagram

Project summary and resume bullets
See `PROJECT_SUMMARY.md` for a short narrative and resume-ready bullets.

Security & cost
- This repo intentionally only commits plan JSONs and sanitized outputs. No secrets or real account credentials are committed.
- Use `infracost` locally for quick cost estimates. See `demo/` for sample output.

Contributing
See `CONTRIBUTING.md`.
