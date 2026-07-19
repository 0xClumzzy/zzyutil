#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool prowler || exit 1

echo ""
info "=== Prowler Quick Reference ==="
info "Full audit:         prowler -p <aws-profile>"
info "Specific checks:   prowler -p <profile> --checks check1 check2"
info "Output CSV:        prowler -p <profile> --output-format csv"
info "CIS benchmark:     prowler -p <profile> --compliance cis_2.0_aws"
info "JSON report:       prowler -p <profile> --output-format json"
info "List checks:       prowler --list-checks"
echo ""
