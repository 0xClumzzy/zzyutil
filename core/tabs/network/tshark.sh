#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool tshark || exit 1

echo ""
info "=== TShark Quick Reference ==="
info "Capture:           tshark -i eth0"
info "Save PCAP:         tshark -i eth0 -w capture.pcap"
info "Read PCAP:         tshark -r capture.pcap"
info "HTTP:              tshark -Y http.request -T fields -e http.host -e http.request.uri"
info "DNS:               tshark -Y dns -T fields -e dns.qry.name"
info "Stats:             tshark -r capture.pcap -z io,phs"
echo ""
