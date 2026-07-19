#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool proxychains || exit 1

echo ""
info "=== Proxychains Quick Reference ==="
info "Config:            /etc/proxychains.conf"
info "Use:               proxychains <command>"
info "With nmap:         proxychains nmap -sT -Pn target"
info "With curl:         proxychains curl http://target"
info "Type:              strict_chain (default), dynamic_chain, random_chain"
echo ""
