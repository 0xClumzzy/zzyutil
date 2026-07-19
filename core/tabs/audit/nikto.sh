#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nikto || exit 1

echo ""
info "=== Nikto Quick Reference ==="
info "Basic scan:     nikto -h <target>"
info "SSL scan:       nikto -h <target> -ssl"
info "Tuning:         nikto -h <target> -Tuning 123"
info "Output:         nikto -h <target> -o report.html -Format html"
info "Auth:           nikto -h <target> -id user:pass"
echo ""
