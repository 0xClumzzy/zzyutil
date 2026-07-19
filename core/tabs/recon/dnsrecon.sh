#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool dnsrecon || exit 1

echo ""
info "=== dnsrecon Quick Reference ==="
info "Standard enum:   dnsrecon -d example.com"
info "Zone transfer:   dnsrecon -d example.com -t axfr"
info "Brute force:     dnsrecon -d example.com -D wordlist.txt -t brt"
info "SRV records:     dnsrecon -d example.com -t srv"
echo ""
