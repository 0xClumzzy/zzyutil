#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool dirb || exit 1

echo ""
info "=== DIRB Quick Reference ==="
info "Basic scan:        dirb http://target"
info "With wordlist:     dirb http://target /path/to/wordlist.txt"
info "With extension:    dirb http://target -X .php,.html"
info "No stop:           dirb http://target -N 404"
info "SSL:               dirb https://target"
echo ""
