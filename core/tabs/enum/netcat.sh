#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nc || exit 1

echo ""
info "=== Netcat Quick Reference ==="
info "Port scan:        nc -zv <target> 1-1000"
info "Banner grab:      nc -v <target> 80"
info "Listen port:      nc -lvnp 4444"
info "Send file:        nc -w 3 <target> 8080 < file.txt"
info "Receive file:     nc -lvnp 8080 > file.txt"
echo ""
