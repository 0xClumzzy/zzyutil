#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool hcxdumptool || exit 1

echo ""
info "=== hcxdumptool Quick Reference ==="
info "Capture PMKID/handshake: sudo hcxdumptool -i wlan0 -o capture.pcapng"
info "Filter BSSID:            sudo hcxdumptool -i wlan0 -o capture.pcapng --filterlist=bssids.txt --filtermode=2"
info "Status:                  sudo hcxdumptool -i wlan0 -o capture.pcapng --status"
info "Timeout:                 sudo hcxdumptool -i wlan0 -o capture.pcapng --timeout=120"
echo ""
