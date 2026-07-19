#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool lynis || exit 1

echo ""
info "=== Lynis Quick Reference ==="
info "Full audit:     sudo lynis audit system"
info "Quick scan:     sudo lynis audit system --quick"
info "Pentest mode:   sudo lynis audit system --pentest"
info "Show commands:  sudo lynis show commands"
info "Show tests:     sudo lynis show tests"
info "Show warnings:  sudo lynis show warnings"
echo ""
