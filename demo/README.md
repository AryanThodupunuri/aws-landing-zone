Demo artifacts
This folder contains demo helpers and sanitized sample plan JSON.

Files:
- `plan.sh` - quick script to produce a plan and sanitized JSON (plan-only).
- `example-plan.sanitized.json` - checked-in sanitized example plan (if added).
- `sanitize_plan.py` - sanitizer to redact account IDs and ARNs.

How to reproduce locally
1. From repo root:
   ./demo/plan.sh

Security notes
- Do not commit non-sanitized plan JSON files.
- The sanitizer replaces 12-digit account IDs and ARNs; review manually before committing.