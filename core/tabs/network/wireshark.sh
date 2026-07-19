#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool wireshark wireshark-qt || exit 1

echo ""
info "=== Wireshark Quick Reference ==="
info "Launch GUI:     wireshark"
info "Open interface: wireshark -i eth0"
info "Read PCAP:      wireshark -r capture.pcap"
info "CLI (tshark):   tshark -i eth0"
echo ""
info "Run 'wireshark' to launch the GUI."
