#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== Linux Smart Enumeration (LSE) Quick Reference ==="
info "Download:  curl -L https://github.com/diego-treitos/linux-smart-enumeration/raw/master/lse.sh -o lse.sh"
info "Run:       chmod +x lse.sh && ./lse.sh"
info "Level:     ./lse.sh -l 3 (verbose output)"
info "Specific:  ./lse.sh -i (interactive mode)"
echo ""
