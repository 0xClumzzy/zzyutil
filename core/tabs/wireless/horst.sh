#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool horst || exit 1

echo ""
info "=== Horst Quick Reference ==="
info "Launch:                 sudo horst -i wlan0mon"
info "Compact view:           sudo horst -i wlan0mon -c"
info "Channel hop:            sudo horst -i wlan0mon -C 1-11"
info "Detailed stats:         sudo horst -i wlan0mon -d"
echo ""
