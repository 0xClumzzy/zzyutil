#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool whois || exit 1

echo ""
info "=== WhoisXML Quick Reference ==="
info "Domain whois:   whois <domain>"
info "IP whois:       whois <ip_address>"
info "Referral:       whois -h whois.arin.net <ip>"
echo ""
