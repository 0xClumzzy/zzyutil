#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool stormspotter || exit 1

echo ""
info "=== Stormspotter Quick Reference ==="
info "Start backend:  stormspotter backend"
info "Start frontend: stormspotter frontend"
info "Login Azure:    Use browser after frontend starts"
echo ""
