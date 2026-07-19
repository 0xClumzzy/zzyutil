#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool strings || exit 1

echo ""
info "=== Strings Quick Reference ==="
info "Extract strings:       strings binary"
info "Min length:            strings -n 10 binary"
info "From offset:           strings -o binary (show byte offset)"
info "Encoding:              strings -e l binary (16-bit little endian)"
info "All encodings:         strings -e l -e b binary"
echo ""
