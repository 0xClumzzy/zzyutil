#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool exiftool || exit 1

echo ""
info "=== ExifTool Quick Reference ==="
info "Read metadata:         exiftool file.jpg"
info "Read all:              exiftool -a file.jpg"
info "Remove metadata:       exiftool -all= file.jpg"
info "Specific tag:          exiftool -Author file.jpg"
info "JSON output:           exiftool -j file.jpg"
info "Recursive:             exiftool -r directory/"
echo ""
