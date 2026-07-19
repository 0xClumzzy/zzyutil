#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool maltego || exit 1

echo ""
info "=== Maltego Quick Reference ==="
info "Start Maltego:    maltego"
info "Transforms:       Use built-in transforms for OSINT"
info "Export:           File > Export Graph"
echo ""
