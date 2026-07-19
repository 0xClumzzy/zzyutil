#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool shodan || exit 1

echo ""
info "=== Shodan CLI Quick Reference ==="
info "Search:          shodan search <query>"
info "Host info:      shodan host <ip>"
info "My IP:          shodan myip"
info "Info:           shodan info"
info "Init API:       shodan init <API_KEY>"
echo ""
