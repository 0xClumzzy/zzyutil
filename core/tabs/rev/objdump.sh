#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool objdump || exit 1

echo ""
info "=== objdump Quick Reference ==="
info "Disassemble:            objdump -d binary"
info "Intel syntax:           objdump -d -M intel binary"
info "Sections:               objdump -h binary"
info "Symbols:                objdump -t binary"
info "Headers:                objdump -x binary"
info "PLT/GOT:                objdump -d -j .plt.sec binary"
info "Relocations:            objdump -r binary"
info "Source interleave:      objdump -d -S binary"
echo ""
