.PHONY: fmt validate plan sanitize

fmt:
	terraform fmt -recursive

validate:
	cd examples/minimal && terraform init -backend=false && terraform validate

plan:
	cd examples/minimal && terraform init -backend=false && terraform plan -out=plan.tfplan -var-file=../..//terraform.tfvars.example && terraform show -json plan.tfplan > ../demo/example-plan.json

sanitize:
	python3 demo/sanitize_plan.py demo/example-plan.json demo/example-plan.sanitized.json