#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool scout || exit 1

echo ""
info "=== ScoutSuite Quick Reference ==="
info "AWS scan:        scout aws --profile <profile>"
info "Azure scan:      scout azure --cli --user-account"
info "GCP scan:        scout gcp --user-account"
info "Specific service: scout aws --services iam s3"
info "Report only:     scout aws --report-dir <dir>"
echo ""
