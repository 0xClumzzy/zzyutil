#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool stegseek || exit 1

echo ""
info "=== Stegseek Quick Reference ==="
info "Crack password:         stegseek --crack stego.jpg wordlist.txt"
info "Extract only:           stegseek --seed stego.jpg"
info "Force (no checksum):    stegseek --crack --force stego.jpg wordlist.txt"
info "Verbose:                stegseek --crack --verbose stego.jpg wordlist.txt"
echo ""
