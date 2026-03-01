#!/usr/bin/env python3
import sys
import re
import json

if len(sys.argv) < 2:
    print("usage: sanitize_plan.py input.json [output.json]")
    sys.exit(1)

infile = sys.argv[1]
outfile = sys.argv[2] if len(sys.argv) > 2 else 'example-plan.sanitized.json'

with open(infile, 'r') as f:
    data = f.read()

# redact 12-digit AWS account ids and ARNs
data = re.sub(r'\b[0-9]{12}\b', 'ACCOUNT_ID_REDACTED', data)
data = re.sub(r'arn:aws:[^"]+', 'ARN_REDACTED', data)
data = re.sub(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}', 'redacted@example.com', data)

with open(outfile, 'w') as f:
    f.write(data)

print("sanitized ->", outfile)