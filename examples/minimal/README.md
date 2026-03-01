Quick reproducible plan (no apply)
1. Install Terraform 1.x (recommended)
2. From repo root:
   cd examples/minimal
   terraform init -backend=false
   terraform plan -out=plan.tfplan -var-file=../../terraform.tfvars.example
   terraform show -json plan.tfplan > ../../demo/example-plan.json
3. Sanitize the plan:
   python3 ../../demo/sanitize_plan.py ../../demo/example-plan.json ../../demo/example-plan.sanitized.json
