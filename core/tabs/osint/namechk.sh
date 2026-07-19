#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool namechk || exit 1

echo ""
info "=== Namechk Quick Reference ==="
info "Check username:   namechk <username>"
info "Output JSON:      namechk --format json <username>"
echo ""
