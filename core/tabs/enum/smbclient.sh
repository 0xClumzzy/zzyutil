#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool smbclient || exit 1

echo ""
info "=== SMBClient Quick Reference ==="
info "List shares:        smbclient -L //target -N"
info "Connect share:      smbclient //target/share -N"
info "With creds:         smbclient //target/share -U username"
info "Recursive get:      smbclient //target/share -N -c 'prompt OFF; recurse; mget *'"
echo ""
