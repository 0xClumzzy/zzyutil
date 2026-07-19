#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool r2 || exit 1

echo ""
info "=== radare2 Quick Reference ==="
info "Open file:              r2 ./binary"
info "Analyze all:            aaa"
info "Show functions:         afl"
info "Disassemble at:         pdf @ main"
info "Seek to address:        s 0x400000"
info "Print string:           ps @ addr"
info "Write mode:             oo+"
info "Visual mode:            V (then p to cycle views)"
info "Graph view:             VV"
info "Quit:                   q"
echo ""
info "Also check: rizin (modern fork of radare2)"
echo ""
