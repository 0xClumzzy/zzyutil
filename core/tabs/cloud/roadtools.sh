#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool roadrecon || exit 1

echo ""
info "=== ROADtools Quick Reference ==="
info "Login:           roadrecon auth -u <user> -p <pass>"
info "Dump Azure AD:   roadrecon gather"
info "GUI viewer:      roadrecon gui"
info "Query tool:      roadrecon-plugin <plugin>"
echo ""
