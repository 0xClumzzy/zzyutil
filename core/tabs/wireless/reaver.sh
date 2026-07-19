#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool reaver || exit 1

echo ""
info "=== Reaver Quick Reference ==="
info "WPS attack:             sudo reaver -i wlan0mon -b <BSSID> -vv"
info "With PIN:               sudo reaver -i wlan0mon -b <BSSID> -p <PIN> -vv"
info "Timeout:                sudo reaver -i wlan0mon -b <BSSID> -t 10 -vv"
info "Delay:                  sudo reaver -i wlan0mon -b <BSSID> -d 5 -vv"
info "Channel:                sudo reaver -i wlan0mon -b <BSSID> -c <CH> -vv"
echo ""
