#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool crunch || exit 1

echo ""
info "=== Crunch Quick Reference ==="
info "Min-Max charset:    crunch 6 8 abc123 -o wordlist.txt"
info "Pattern mode:       crunch 8 8 -t @@%%2015 -o wordlist.txt"
info "Default charset:    crunch 4 6 -o wordlist.txt"
info "Compress output:    crunch 4 6 -o wordlist.txt -z gzip"
info "Standard set:       crunch 8 10 -f /usr/share/crunch/charset.lst mixalpha-numeric"
echo ""
