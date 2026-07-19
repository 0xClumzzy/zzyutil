#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nikto || exit 1

echo ""
info "=== Nikto Quick Reference ==="
info "Basic scan:        nikto -h http://target"
info "With port:         nikto -h http://target -p 8080"
info "SSL scan:          nikto -h https://target"
info "Full verbosity:    nikto -h http://target -Display V"
info "Save report:       nikto -h http://target -o report.html"
echo ""
