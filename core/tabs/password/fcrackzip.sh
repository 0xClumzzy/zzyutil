#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool fcrackzip || exit 1

echo ""
info "=== fcrackzip Quick Reference ==="
info "Dictionary:         fcrackzip -D -p wordlist.txt -u archive.zip"
info "Brute force:        fcrackzip -b -l 1-6 -u archive.zip"
info "Charset:            fcrackzip -b -c aA1! -l 4-6 -u archive.zip"
info "Verbose:            fcrackzip -v -D -p wordlist.txt -u archive.zip"
echo ""
