#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool proxychains || exit 1

echo ""
info "=== Proxychains Quick Reference ==="
info "Run via proxy:   proxychains <command>"
info "Edit config:     nano /etc/proxychains.conf"
info "SOCKS5:          socks5 127.0.0.1 9050"
info "Test:            proxychains curl ifconfig.me"
info "Nmap through:    proxychains nmap -sT -Pn <target>"
echo ""
