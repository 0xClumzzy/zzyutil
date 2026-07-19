#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool steghide || exit 1

echo ""
info "=== Steghide Quick Reference ==="
info "Embed data:            steghide embed -cf cover.jpg -ef secret.txt -p password"
info "Extract data:          steghide extract -sf stego.jpg -p password"
info "Info (detect):         steghide info stego.jpg"
info "No password prompt:    steghide extract -sf stego.jpg -p ''"
echo ""
