#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool recon-ng || exit 1

echo ""
info "=== Recon-ng Quick Reference ==="
info "Start console:    recon-ng"
info "Install module:   marketplace install <module>"
info "Run module:       modules load <module>"
info "Workspaces:       workspace create <name>"
info "Show DB:          db insert <table>"
echo ""
