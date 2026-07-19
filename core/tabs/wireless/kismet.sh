#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool kismet || exit 1

echo ""
info "=== Kismet Quick Reference ==="
info "Server:                 sudo kismet"
info "Web UI:                 http://localhost:2501"
info "Log dir:                /var/log/kismet/ or ~/Kismet/"
info "More info:              Kismet has a web interface for all interaction"
echo ""
