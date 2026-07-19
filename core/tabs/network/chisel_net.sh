#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool chisel || exit 1

echo ""
info "=== Chisel Quick Reference ==="
info "Server:            chisel server -p 8080 --reverse"
info "Client socks:      chisel client <server_ip>:8080 R:socks"
info "Client fwd:        chisel client <server_ip>:8080 R:8000:localhost:80"
info "With auth:         chisel server -p 8080 --auth user:pass"
echo ""
