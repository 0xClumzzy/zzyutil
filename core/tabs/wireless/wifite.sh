#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool wifite || exit 1

echo ""
info "=== Wifite Quick Reference ==="
info "Run Wifite:            sudo wifite"
info "Band select:           sudo wifite -b 5 (5GHz only)"
info "WPS only:              sudo wifite --wps"
info "WPA only:              sudo wifite --wpa"
info "No PMKID:              sudo wifite --no-pmkid"
echo ""
