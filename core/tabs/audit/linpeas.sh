#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== LinPEAS Quick Reference ==="
info "Download:  curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -o linpeas.sh"
info "Run:       chmod +x linpeas.sh && ./linpeas.sh"
info "Output:    ./linpeas.sh -a (all checks)"
info "Specific:  ./linpeas.sh -s (quick scan)"
echo ""
