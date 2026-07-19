#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool chisel || exit 1

echo ""
info "=== Chisel Quick Reference ==="
info "Server:           chisel server -p <port> --reverse"
info "Connect client:   chisel client <server>:<port> <remote_port>:<local_port>"
info "SOCKS proxy:      chisel client <server>:<port> socks"
info "Reverse proxy:    chisel client <server>:<port> R:<remote_port>:<local_host>:<local_port>"
echo ""
