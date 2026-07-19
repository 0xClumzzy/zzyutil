#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool dnsenum || exit 1

echo ""
info "=== dnsenum Quick Reference ==="
info "Enum domain:     dnsenum example.com"
info "With wordlist:   dnsenum -f wordlist.txt example.com"
info "Threading:       dnsenum --threads 10 example.com"
echo ""
