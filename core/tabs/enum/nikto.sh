#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nikto || exit 1

echo ""
info "=== Nikto Quick Reference ==="
info "Basic scan:     nikto -h http://target"
info "Specific port:  nikto -h http://target -p 8443"
info "Full scan:      nikto -h http://target -Display V -o report.html"
info "SSL:            nikto -h https://target"
echo ""
