#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/examples/minimal"

terraform fmt -recursive
terraform init -backend=false
terraform validate

terraform plan -out=plan.tfplan -var-file="$ROOT/terraform.tfvars.example"
terraform show -json plan.tfplan > "$ROOT/demo/example-plan.json"

# sanitize
python3 "$ROOT/demo/sanitize_plan.py" "$ROOT/demo/example-plan.json" "$ROOT/demo/example-plan.sanitized.json"
echo "Sanitized plan -> $ROOT/demo/example-plan.sanitized.json"