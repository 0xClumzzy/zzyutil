#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool theharvester || exit 1

echo ""
info "=== theHarvester Quick Reference ==="
info "Email search:    theHarvester -d example.com -b google"
info "All sources:     theHarvester -d example.com -b all"
info "DNS brute:       theHarvester -d example.com -b dns -l 100"
echo ""
