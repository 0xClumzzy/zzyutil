#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool recon-ng || exit 1

echo ""
info "=== Recon-ng Quick Reference ==="
info "Launch CLI:       recon-ng"
info "Marketplace:      marketplace install <module>"
info "Workspaces:       workspaces create <name>"
info "Keys:             keys add <service> <api_key>"
echo ""
