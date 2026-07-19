#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool rustscan || exit 1

echo ""
info "=== RustScan Quick Reference ==="
info "Scan host:        rustscan -a <target>"
info "With Nmap:        rustscan -a <target> -- -sV -sC"
info "Quick scan:       rustscan -a <target> --tries 1"
info "Batch scan:       rustscan -a targets.txt"
echo ""
