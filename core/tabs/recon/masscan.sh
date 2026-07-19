#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool masscan || exit 1

echo ""
info "=== Masscan Quick Reference ==="
info "Scan ports:  masscan -p1-65535 <target>"
info "With rate:   masscan -p80,443 --rate=1000 <target>"
info "Full scan:   masscan -p0-65535 --rate=10000 <target>"
info "Export:      masscan -p80 --rate=1000 -oL output.txt <target>"
echo ""
