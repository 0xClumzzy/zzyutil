#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool subfinder || exit 1

echo ""
info "=== Subfinder Quick Reference ==="
info "Discover subs:    subfinder -d example.com"
info "With output:      subfinder -d example.com -o subs.txt"
info "Recursive:        subfinder -d example.com -recursive"
info "All sources:      subfinder -d example.com -all"
echo ""
