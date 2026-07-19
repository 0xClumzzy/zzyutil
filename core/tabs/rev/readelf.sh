#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool readelf || exit 1

echo ""
info "=== readelf Quick Reference ==="
info "Headers:                readelf -h binary"
info "Sections:               readelf -S binary"
info "Segments:               readelf -l binary"
info "Symbols:                readelf -s binary"
info "Dynamic:                readelf -d binary"
info "Relocs:                 readelf -r binary"
info "Notes:                  readelf -n binary"
echo ""
