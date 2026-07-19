#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool gobuster || exit 1

echo ""
info "=== Gobuster Quick Reference ==="
info "Dir busting:   gobuster dir -u http://target -w wordlist.txt"
info "DNS busting:   gobuster dns -d example.com -w subdomains.txt"
info "VHost bust:    gobuster vhost -u http://target -w wordlist.txt"
info "Extensions:    gobuster dir -u http://target -w wordlist.txt -x php,txt,html"
echo ""
