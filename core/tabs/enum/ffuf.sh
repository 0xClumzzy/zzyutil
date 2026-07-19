#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool ffuf || exit 1

echo ""
info "=== FFUF Quick Reference ==="
info "Dir fuzz:      ffuf -u http://target/FUZZ -w wordlist.txt"
info "Extensions:    ffuf -u http://target/FUZZ -w wordlist.txt -e .php,.txt"
info "Param fuzz:    ffuf -u http://target/page.php?FUZZ=test -w params.txt"
info "VHost fuzz:    ffuf -u http://target -H \"Host: FUZZ.target.com\" -w vhosts.txt"
info "Filter:        ffuf -u http://target/FUZZ -w wordlist.txt -fc 404"
echo ""
