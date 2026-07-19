#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool objdump || exit 1

echo ""
info "=== objdump PLT/GOT Inspection ==="
info "PLT entries:            objdump -d -j .plt binary"
info "PLT.sec:                objdump -d -j .plt.sec binary"
info "GOT entries:            objdump -R binary"
info "Dynamic symbols:        objdump -T binary"
info "Full disassembly:       objdump -d -M intel binary"
echo ""
info "Use for ret2plt, GOT overwrite, and PLT resolution analysis"
echo ""
