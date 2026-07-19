#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool airmon-ng || exit 1

echo ""
info "=== Aircrack-ng Suite Quick Reference ==="
info "Monitor mode:          sudo airmon-ng start wlan0"
info "Scan (airodump):       sudo airodump-ng wlan0mon"
info "Target AP:             sudo airodump-ng -c <ch> --bssid <MAC> -w capture wlan0mon"
info "Deauth (aireplay):     sudo aireplay-ng -0 5 -a <AP_MAC> -c <STA_MAC> wlan0mon"
info "Crack (aircrack):      aircrack-ng -w wordlist.txt capture-01.cap"
echo ""
