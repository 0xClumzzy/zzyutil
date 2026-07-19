#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool wpscan || exit 1

echo ""
info "=== WPScan Quick Reference ==="
info "Basic scan:        wpscan --url http://target"
info "User enum:         wpscan --url http://target --enumerate u"
info "All plugins:       wpscan --url http://target --enumerate ap"
info "Vuln plugins:      wpscan --url http://target --enumerate vp"
info "API token:         wpscan --url http://target --api-token <token>"
info "Pass brute:        wpscan --url http://target --passwords wordlist.txt --usernames admin"
echo ""
