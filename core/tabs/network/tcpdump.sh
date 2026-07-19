#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool tcpdump || exit 1

echo ""
info "=== tcpdump Quick Reference ==="
info "Capture all:       tcpdump -i eth0"
info "Count:             tcpdump -i eth0 -c 100"
info "Save:              tcpdump -i eth0 -w capture.pcap"
info "Read:              tcpdump -r capture.pcap"
info "Filter port:       tcpdump -i eth0 port 80"
info "Filter host:       tcpdump -i eth0 host 192.168.1.1"
info "Filter both:       tcpdump -i eth0 src host 10.0.0.1 and dst port 443"
info "No DNS:            tcpdump -i eth0 -n"
echo ""
