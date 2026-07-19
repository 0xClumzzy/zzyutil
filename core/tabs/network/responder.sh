#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool responder || exit 1

echo ""
info "=== Responder Quick Reference ==="
info "Run all:           sudo responder -I eth0"
info "Basic:             sudo responder -I eth0 -wrf"
info "Only LLMNR:        sudo responder -I eth0 -lm"
info "Only NBT-NS:       sudo responder -I eth0 -n"
info "Analyze only:      sudo responder -I eth0 -A"
echo ""
