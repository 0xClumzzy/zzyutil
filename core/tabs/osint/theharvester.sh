#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool theHarvester || exit 1

echo ""
info "=== theHarvester Quick Reference ==="
info "Email harvest:  theHarvester -d <domain> -b all"
info "Subdomains:     theHarvester -d <domain> -b google,bing"
info "Limit results:  theHarvester -d <domain> -b all -l 200"
info "Output file:    theHarvester -d <domain> -b all -f report.html"
echo ""
