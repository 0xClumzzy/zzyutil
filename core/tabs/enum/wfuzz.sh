#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool wfuzz || exit 1

echo ""
info "=== WFuzz Quick Reference ==="
info "Dir fuzz:      wfuzz -w wordlist.txt http://target/FUZZ"
info "Param fuzz:    wfuzz -w params.txt http://target/page.php?FUZZ=1"
info "Auth bypass:   wfuzz -w users.txt -w passwords.txt --basic FUZZ:FUZ2Z http://target"
info "HC/HW filter:  wfuzz -w wordlist.txt --hc 404 http://target/FUZZ"
echo ""
