#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== Ligolo-ng Quick Reference ==="
info "Proxy:           ./proxy -selfcert"
info "Agent:           ./agent -connect <proxy_ip>:11601 -ignore-cert"
info "Add tunnel:      session; ifconfig tun0 up; ip r add <target_cidr> dev tun0"
echo ""
