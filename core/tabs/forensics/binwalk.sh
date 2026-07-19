#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool binwalk || exit 1

echo ""
info "=== Binwalk Quick Reference ==="
info "Analyze file:         binwalk firmware.bin"
info "Extract files:        binwalk -e firmware.bin"
info "Extract + recurse:    binwalk -Me firmware.bin"
info "Signature only:       binwalk -S firmware.bin"
info "Entropy:              binwalk -E firmware.bin"
echo ""
