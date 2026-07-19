#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool ssh-audit || exit 1

echo ""
info "=== ssh-audit Quick Reference ==="
info "Scan host:      ssh-audit <target>"
info "Scan port:      ssh-audit <target>:<port>"
info "JSON output:    ssh-audit -j <target>"
info "Key scan:       ssh-audit --skip-rate-test <target>"
echo ""
