#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool ssh || exit 1

echo ""
info "=== SSH Quick Reference ==="
info "Connect:        ssh <user>@<target>"
info "Key auth:       ssh -i <key> <user>@<target>"
info "Port:           ssh -p <port> <user>@<target>"
info "Tunnel:         ssh -L <local_port>:<target>:<remote_port> <user>@<host>"
info "Dynamic proxy:  ssh -D <port> <user>@<target>"
info "X forwarding:   ssh -X <user>@<target>"
echo ""
