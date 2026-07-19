#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool foremost || exit 1

echo ""
info "=== Foremost Quick Reference ==="
info "Carve disk image:     foremost -i disk.dd"
info "Output dir:           foremost -i disk.dd -o /tmp/output"
info "Specific types:       foremost -t jpeg,png,pdf -i disk.dd"
info "Verbose:              foremost -v -i disk.dd"
echo ""
